#!/bin/bash

if [ ! -e "$1" ]; then

		touch "${1}-placeholder"
		while ! ln -s "${1}-placeholder" "${1}-lock" 2>/dev/null; do
        	#echo $placeholder-lock $1 currently being accessed by other user"
        	sleep 5
        	done
		rm "${1}-placeholder"
		exit 0

else

	while ! ln -s "$1" "${1}-lock" 2>/dev/null; do
	#echo $1-notplaceholder $1 currently being accessed by other user"
	sleep 5
	done
	exit 0

fi

