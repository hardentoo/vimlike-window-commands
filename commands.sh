#!/bin/bash
shopt -s expand_aliases


WINI=$(xdotool getwindowfocus)
WIN=$(((xprop -id $WINI | grep "WM_CLASS") | tr "\"" "\n") | sed -n 2p)


MAIN_DIALOG='
<window width-request="300" resizable="false">
  <vbox>
    <hbox>
      <text>
        <label>'$WIN'</label>
      </text>
      <entry activates_default="true">
        <variable>RET</variable>
      </entry>
      <button can-default="true" has-default="true"/></button>
    </hbox>
  </vbox>
</window>
'
export MAIN_DIALOG

TXT=$(gtkdialog --program=MAIN_DIALOG -w | head -n1)
TXT=${TXT:5:${#TXT}}
TXT=${TXT:0:${#TXT}-1}


#gtk source for zenity
#escape commands
#fork vs sequential '( & )' ';'
#verbose mode


#read -p "$WIN\$ " CMD
#TXT=$(zenity --entry --text=$WIN)


TXT=" $TXT"
TXT=${TXT// ;/ ; :}
#TXT=${TXT/;;/ ;}


##PARSE SETTINGS WRT. CONTEXT
HEADER=""
while read p; do #foreach line p in file
  if [[ $p == "[$WIN]" ]]; then #p is a header
    HEADER=$p
  elif [[ $p == "["*"]" ]]; then #p is wrong header
    HEADER="//"
  elif [[ $p == "#"* ]]; then : #comment
  elif [[ $HEADER == "[$WIN]" || $HEADER == "" ]] && [[ $p == "alias "* ]]; then 
    AR=($p)
    CMD=${AR[1]}
    CMD2=${p:${#CMD}+7:${#p}}
    alias $CMD="$CMD2"
  fi
done <~/.xcmds


##PARSE REPITITIONS2
TXT2=""
IFS=":" read -r -a array <<< "$TXT"
for i in "${array[@]}"; do
  NUM=$(echo $i | grep -o "[1-9]*")
  if [[ ${#NUM} == 0 ]]; then
    TXT2=$TXT2" "$i
  else
    TXT2=$TXT2" "$(eval "printf '${i:${#NUM}:${#i}}; %.0s' {1..$NUM}")
  fi
done
TXT=$TXT2

TXT=${TXT// :/ ;}
if [[ $TXT == ";"* ]]; then
  TXT=${TXT/ ;/ }
fi

$(wmctrl -i $WINI)
eval $TXT
