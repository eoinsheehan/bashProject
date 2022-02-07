
#!/bin/bash
if [ ! -p server.pipe ]; then

        mkfifo server.pipe

else
        echo "server.pipe already exists"

fi

while true; do

trap ctrl_c INT
function ctrl_c() {
        rm -f "server.pipe"
        exit 0
}

	# piped from the client
	read -a ARR input < server.pipe

	# capture client id
	id="${ARR[-1]}"

	#remove client id from array
	unset ARR[-1]

	# echo ${ARR[*]}"
	case "${ARR[0]}" in
		create_database)
		./P.sh "${ARR[1]}"
		if [ $? -eq 0 ];then
			./create_database.sh "${ARR[@]:1}" > "${id}.pipe"
			./V.sh "${ARR[1]}"
		fi
		;;
		create_table)
		./P.sh "${ARR[1]}" 
		if [ $? -eq 0 ];then
			./create_table.sh "${ARR[@]:1}" > "${id}.pipe"
			./V.sh "${ARR[1]}"
		fi
		;;

		insert)
		./P.sh "${ARR[1]}-${ARR[2]}"
		if [ $? -eq 0 ];then
			./insert.sh "${ARR[@]:1}" > "${id}.pipe"
			./V.sh "${ARR[1]}-${ARR[2]}"
		fi
		;;

		select)

		./P.sh "${ARR[1]}-${ARR[2]}"
		if [ $? -eq 0 ];then
			./select.sh "${ARR[@]:1}" > "${id}.pipe"
			./V.sh "${ARR[1]}-${ARR[2]}"
		fi
		;;

		shutdown)
			rm -f server.pipe
			exit 0
		;;
                exit)
                        rm -f server.pipe
                        exit 0
                ;;


		*)
		echo "Error: bad request"
		rm -f server.pipe
		exit 1
esac

done
