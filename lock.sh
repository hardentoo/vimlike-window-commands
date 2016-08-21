scrot -q 1 ~/Pictures/lock.png

convert -scale 10% ~/Pictures/lock.png  ~/Pictures/lock.png

convert ~/Pictures/lock.png -filter Gaussian  \
          -define filter:sigma=10000 -scale 1000%  ~/Pictures/lock.png


convert -composite -gravity center ~/Pictures/lock.png  ~/Pictures/arch.png ~/Pictures/lock.png


i3lock -i ~/Pictures/lock.png
