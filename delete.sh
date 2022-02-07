#!/bin/bash

# Check that the correct number of args passed
if [ $# -ne 3 ]; then
        echo "Error: parameter problem"
        exit 1
elif
         [ ! -d "$1" ]; then
        echo "Error: DB does not exist"
        exit 1
elif [ ! -f "$1/$2" ]; then
        echo "Error: table does not exist"
        exit 1
else
        # Calculate no. of columns in table
        col_count=$(head -1 $1/$2 | tr "," "\n" | wc -l)
        for var in ${3//,/" "}; do
                if [ "$var" -eq 1 ]; then
                        echo "Error: you cannot remove the table header"
                        exit 1
                fi
                if [ "$var" -gt $col_count ] || [ "$var" -lt 1 ]; then
                        echo "Error: row $var does not exist."
                        exit 1
                fi
        done
        sed -i "$3"d "$1/$2"
	echo "OK: Rows deleted successfully"
        exit 0
fi
