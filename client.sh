#!/bin/bash

id=$1

if [ $# -eq 1 ]; then

if [ ! -p "${id}.pipe" ]; then

	mkfifo "${id}.pipe"

else
	echo "${id}.pipe already exists"

fi

while true; do

trap ctrl_c INT
function ctrl_c() {
        rm -f "${id}.pipe"
        exit 0
}

	read input

	if [[ "$input" = "shutdown" || "$input" = "exit" ]]; then
		echo "$input ${id}" > server.pipe
		rm -f "${id}.pipe"
		exit 0
	else
	echo "$input ${id}" > server.pipe

	while read result; do
		first_word=$(echo "$result" | cut -d " " -f1)
		# if the first word is OK: then
		if [[ "$first_word" = "OK:" ]];then
		echo "command successfully executed"

		elif [[ "$first_word" = "Error:" ]];then
		echo "command unsuccessful"

		elif [[ "$first_word" = "start_result" || "$first_word" = "end_result" ]];then
			continue
		else
			#output=$(echo "result" | tail -n +1)
			echo "$result"
		fi
		#else if the first word is Error: then

		# else echo result minus first and last line
		#echo $result"
		done < "${id}.pipe"


fi

done
else

	echo "Error: only accepting one argument" 

fi
