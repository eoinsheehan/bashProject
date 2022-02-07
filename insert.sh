#!/bin/bash

#creates a table in the directory with headers comma seperated

#should say if too many or too few arguments

# count how many columns passed to insert
count=0

# count how many headings are in the table
headings=0


# check that three parameters have been passed
if [ $# -ne 3 ]; then
	echo "Error: parameters problem"
	exit 1


elif [ -d "$1" ]; then
	if !  [ -f "$1/$2" ]; then
		echo 'Error: table does not exist'
		exit 1
	else
	# for loop to count the number of columns passed
		IFS=","
		for var in $3; do
		((count++))
		done

	# check the number of column headings
	for var in $(head -n 1 $1/$2); do
		((headings++))
		done
		IFS=" "
		# only add to table in case number of columns match
		if [ $count -eq $headings ]; then
		echo $3>>$1/$2
		echo "OK: tuple inserted"
		exit 0
		else
		echo "Error: number of columns in tuple does not match schema"
		exit 1
		fi

	fi

else 
	echo "Error:DB does not exist"
	exit 1


fi
