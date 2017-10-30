#!/bin/sh
cat ~/.surf/history.txt | sort -ru | dmenu -l 10 -b -i | xprop -id `cat ~/.surf/id` -f SURF_URI 8s -set _SURF_URI
