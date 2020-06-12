#Henry Cooper
#Task 1
#Checking the user input

#Where is the file coming from? Is it url bassed?
if [[ $# == 0 ]]; then
        echo "No argument supplied. Enter url or localfile"
        read -p "URL or Filename: " fileName
        echo $fileName | grep "http*"
	#Url File
        if [[ $? == 0 ]]; then
                echo "URL Given, Downloading file"
                wget $fileName
                if [[ $? == 0 ]]; then
                        file="legends.txt"
                        echo "file download successful"
                else
                        echo "File download unsuccessful"
                        exit 1
                fi
	#File is local
        else
                if [[ ! -f $fileName ]]; then
                        echo "localfile does not exist"
                        echo "Exiting"
                        exit 1
                else
                        file=$fileName
                fi
        fi
fi
if [[ $# > 0 ]];
then
        fileName=$1
        echo $fileName | grep "http*"

        if [[ $? == 0 ]]; then
                echo "Downloading file"
                wget $fileName
                if [[ $? == 0 ]]; then
                        file="legends.txt"
                        echo "file download successful"
                else
                        echo "Download Failed"
                        exit 1
                fi
        fi
fi	
#Function to set passwords
function setPassword {
username=$1
#sets each users password automaticly
echo "setting password"
if [[ $username == "bill" ]]; then
        password="not_cracked"
elif [[ $username = "ozalp" ]]; then
        password="12udort"
elif [[ $username = "sklower" ]]; then
        password="theikh!!!"
elif [[ $username = "kidle" ]]; then
        password="jilland1"
elif [[ $username = "kurt" ]]; then
        password="sacristy"
elif [[ $username = "schmidt" ]]; then
        password="wendy!!!"
elif [[ $username = "hpk" ]]; then
        password="graduat"
elif [[ $username = "tbl" ]]; then
        password="pnn521"
elif [[ $username = "jfr" ]]; then
        password="m5%ghj"
elif [[ $username = "mark" ]]; then
        password="uio"
elif [[ $username = "dmr" ]]; then
        password="dmac"
elif [[ $username = "ken" ]]; then
        password="p/q2-q4!"
elif [[ $username = "sif" ]]; then
        password="axolotl"
elif [[ $username = "scj" ]]; then
        password="pdq;dq"
elif [[ $username = "pjw" ]]; then
        password="uucpuucp"
elif [[ $username = "bwk" ]]; then
        password="/.,/.,"
elif [[ $username = "uucp" ]]; then
        password="whatnot"
elif [[ $username = "srb" ]]; then
        password="bourne"
elif [[ $username = "mckusick" ]]; then
        password="foobar"
elif [[ $username = "peter" ]]; then
        password="...hello"
elif [[ $username = "henry" ]]; then
        password="sn74193n"
elif [[ $username = "jkf" ]]; then
        password="sherril."
elif [[ $username = "fateman" ]]; then
        password="apr1744"
elif [[ $username = "fabry" ]]; then
        password="561cml"
fi
#Displays outcome of password setting
echo $username:$password | sudo chpasswd
if [[ $? == 0 ]]; then
        echo "Password for $username set"
else
        echo "Password not set, oh no!"
fi
}
#Function to create users 
function createUser {
        username=$1
        group=$2
        homedir=$3
        shell=$4
        echo "creating $username"
	sudo useradd -m -d $homedir -s $shell $username

        if [[ $? == 0 ]]; then
                echo "========"
                echo "User $username created successfully"

                setPassword $username
        else
                echo "yeah nah $username already exists"
        fi
}
#loops through the file.
count=0
IFS=":"
while read username col2 col3 col4 col5 group homedir shell;do		#big ol loop
if [[ $count -gt 0 ]]; then
        echo $username $group $homedir $shell
        createUser $username $group $homedir $shell
fi
count=$((count+1))
done < $file
