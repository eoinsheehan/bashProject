#!/bin/bash


if [ $# -eq 0 ]; then
 echo "Error: No parameter was provided"
	exit 1

elif [ ! $# -eq 1 ]; then
	echo "Error: function accepts only 1 argument"
	exit 1

elif [ -d "$1" ]; then
	echo "Error: DB already exists"
	exit 1

else
	mkdir "$1"
	echo "OK: database created"
	exit 0

fi
