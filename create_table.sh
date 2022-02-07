#!/bin/bash

#creates a table in the directory with headers comma seperated

#should say if too many or too few arguments

# check if the number of parameters is not equal to three
if [ $# -ne 3 ]; then
	echo "Error: parameters problem"
	exit 1


# check that the database actually exists
elif [ -d "$1" ]; then

# check if the table already exists
	if [ -f "$1/$2" ]; then
		echo "Error: table already exists"
		exit 1

# if not then create it in the location and append 3rd parameter as first line
	else
		touch $1/$2
		echo $3>$1/$2
		echo "OK: table created"
		exit 0
	fi

# if database does not exist
else
	echo "Error: DB does not exist"
	exit 1

fi
