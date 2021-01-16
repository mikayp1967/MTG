#!/bin/bash
SPACES="               "
printf "DELAY : 1200\n"
for BEF in `seq 0 10`
do
	for MID in `seq 1 12`
	do
	    printf "Keyboard : Enter : KeyPress\nTYPE TEXT : ${BEF}/${MID}\nKeyboard : Enter : KeyPress\n"
		for AFT in `seq 0 12`
        do
		        printf "Keyboard : Enter : KeyPress\n"
			    printf "TYPE TEXT : /who gu:${SPACES:0:$BEF}Shocker${SPACES:0:$MID}Squad${SPACES:0:$AFT}\n"
				printf "Keyboard : Enter : KeyPress\n"
				printf "DELAY : 5200\n"
	
		done
	done
done