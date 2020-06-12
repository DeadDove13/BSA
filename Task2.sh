#Henry Cooper
#Task 2

logfile="/home/$(whoami)/logfile_task2.txt"

# Checking if the logfile exists already or not
if [ ! -f $logfile ]
then 
	touch $logfile
	echo "$(date) : Log file created" >> $logfile
else
	echo "*************************************************************************" >> $logfile
	echo "                                                                         " >> $logfile
	echo "$(date) : Existing logfile found at $logfile" >> $logfile
	echo "$(date) : Countinuing with above logfile" >> $logfile
fi

directory_path=$1

# Checking user input is argument or not
if [ -z $directory_path ]
then
	# Asking user input
	msg="No directory path was supplied"
	echo "$(date) : $msg" >> $logfile
	echo "$(date) : Requesting user to provide directory path" >> $logfile
	read -p "Please enter a valid directory path: " directory_path # Reading user input
	echo "$(date) : User supplied: $directory_path" >> $logfile
else
	echo "$(date) : Directory supplied input argument"
fi

#Checking if user provided an existing directory
if [ ! -z $directory_path ]
then
	if [ -d $directory_path ]
	then
		echo "$(date) : Directory found"  >> $logfile
	else
		msg="ERROR - Directory path not supplied. Exiting...." 
		echo "$msg"
		echo "$(date) : $msg" >> $logfile
		exit 1
	fi
else
	msg="ERROR - Directory path is blank. Exiting...."
	echo "$msg"
	echo"$(date) : $msg" >> $logfile
	exit 1
fi

echo "Directory : $directory_path"

directory_name=$(basename $directory_path)
archive_file=$(echo $directory_name.tar.gz)

msg="Compressing the '$directory_name' into tar archive '$archive_file' file"
echo "$msg"
echo "$(date) : $msg" >> $logfile
sudo tar -czf $archive_file $directory_name

if [ -f $archive_file ]
then 
	msg=">>> $directory_name - Backup was successfully created."
	echo "$msg"
	echo "$(date) : $msg" >> $logfile
else
	msg=">>> ERROR - $directory_name Backup failed. Exiting..........."
	echo "$msg"
	echo "$(date) : $msg" >> $logfile
	exit 1
fi

# Details requested to upload to a remote server
echo "The back up file will now be sent to a remote server."
echo "You will need to provide a URL, Port number and Target directory of remote server."

read -p "    Please enter the valid URL or IP address of a remote server (Eg. $(whoami)@10.25.100.1): " url
echo "$(date) : URL address : $url" >> $logfile

read -p "    Please enter the port number: " port
echo "$(date) : Port number : $port" >> $logfile

read -p "    Please enter target remote directory: " remote_directory
echo "$(date) : Remote directory name : $remote_directory" >> $logfile

msg="Please wait. Connecting to remote server...."
echo "$msg"
echo "$(date) : $msg" >> $logfile
echo "Note that you may need to enter your password."

# Checking if remote directory exists
if ssh "$url" "ls $remote_directory > /dev/null 2>&1"
then
	msg="Remote dirctory found. Attempting backup"
	echo "$msg"
	echo "$(date) : $msg" >> $logfile

	scp -P $port $archive_file $url:$remote_directory

	# Checking the archive file copied successfully to  remote server
	if ssh "$url" "[ -f $remote_direstory/$archive_file ]"
	then 
		msg="Successfully copied the archive_file to remote server"
		echo "$msg"
		echo "$(date) : $msg" >> $logfile
	else
		msg="Error occurred while copying the archive_file to remote server. Exiting...."
		echo "$msg"
		echo "$(date) : $msg" >> $logfile
		exit 1	
	fi
else
	msg="Remote server unavalable. Exiting....."
	echo "$msg"
	echo "$(date) : $msg" >> $logfile
	exit 1
fi
