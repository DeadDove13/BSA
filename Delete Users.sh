#Henry Cooper
# Deletes users created in task 1

filename='users.txt'
IFS=":"

while read col1 col2 col3 col4 col5 col6 col7 col8; do
	if ! [[ $col1 == "col1" ]]
	then
		echo "User: $col1"
		echo "Password: $col2"
		echo "Uid, Gid: $col3"
		echo "Name: $col4"
		echo "Groups: $col5"
		echo "Home_Directory: $col6"
		echo "Prefered_Shell: $col7"


		if [ -z "$col1" ]
		then		
			echo "User does not exist"
		else	
			echo "Deleting user...."
			userdel -rf $col1 &> /dev/null
			echo "User have been deleted"
		fi
	fi
done < users.txt
