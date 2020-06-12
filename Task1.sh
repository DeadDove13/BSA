#Henry Cooper
# Task 1

#Checking the user input
file=$1
if [ -z $file ]
then
	echo "no input"
	read -p "Please enter a file path"
fi
if [[ `wget -S --spider $file 2>&1 | grep 'HTTP/1.1 200 OK'` ]]
then
        echo " Remote file found"
       echo " Downloading the file"

	fileName=$(basename $file)

	scriptPath=$(cd `dirname $0` && pwd)
	if [ ! -f $scriptPath/$fileName ]
	then
	wget  -q -P $scriptPath $file
	fi

	file=$scriptPath/$fileName

elif echo $file | grep -q "http"
then
        echo "Remote file could not be found. Exiting..."
        exit 1
else
        file_ext=$(echo "$file" | awk -F "." {'print$2'};)
        if [ ! $file_ext == "" ]
        then
                if [ $file_ext == "txt" ]
                then
                        if [ -f $file ]
                        then
                                echo "importing local file"
                                file=$file
                        else
                                echo " file doesn't exist. Exiting..."
                                exit 1
                        fi
                else
                        echo "'$file' is not a txt file. Exiting..."
                        exit 1
                fi
        fi
fi

file=$1
IFS=":"
while read col1 col2 col3 col4 col5 col6 col7 col8; do
echo $col1 
echo $col2
echo $col3
echo $col4
echo $col5
echo $col6
echo $col7
echo $col8
done <$file

file=$1
createUser() {
echo creating $username
sudo useradd -d /home/$username -m -s /bin/bash $uername

if [[ $? == 0 ]];
then
echo "User $username created successfully"
else
echo "User $username already exists"
fi

sudo echo $username:$password | sudo chpasswd
if [[ $? == 0 ]];
then
echo "User $username password changed"
return 0
else
echo "User $username not changed"
return 1
fi
}

createUser $1 
