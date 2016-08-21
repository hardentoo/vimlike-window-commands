#!/bin/bash

SPATH=$(((xprop -id $1 | grep "WM_NAME") | tr ":" "\n") | sed -n 2p)
SPATH=${SPATH%?}
OUT=$(urxvt -cd "${SPATH/"~"/$HOME}")
