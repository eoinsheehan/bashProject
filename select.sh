#!/bin/bash

#creates a table in the directory with headers comma seperated

if [ $# -lt 2 ]; then
	echo 'Must provide at least two parameters'
	exit 1

elif [ $# -gt 3 ]; then
	echo "Max parameters accepted is three"
	exit 1

elif [ -d $1 ]; then
	if ! [ -f $1/$2 ]; then
		echo 'Error: table does not exist'
		exit 1
	else
		# how many cols are in the table
		col_count=$(head -1 $1/$2 | tr "," "\n" | wc -l)
	fi

	# if no third argument passed print whole table
	if [ $# -eq 2 ]; then
	echo "start_result"
	echo "$(<"$1/$2")"
	echo "end_result"
	exit 0

	else # if there is a third argument passed
		# for fields passed in third argument
		for i in ${3//,/" "}; do
			# if each of these is less than the col count they can be indexed
			if [[ $i -le $col_count && $i -gt 0 ]]; then
				continue
			else
				echo "Error: column $i not in table"
				exit 1
				break
			fi
		done
		# ask why this isn't be passed back in order asked for
		echo "start_result"
		cut -d, -f${3} $1/$2
		echo "end_result"
		exit 0
	fi
	# echo This directory exists

else 
	echo "Error:DB does not exist"
	exit 1


fi
