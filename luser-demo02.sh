#/bin/bash

# Display UID and username of that user executing this script
# Display if the user is the root user or not

# Display UID
echo "Your UID is ${UID}"

# Display username
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"

# Display if the user is root or not
if [[ "${UID}" -eq 0 ]]
then
	echo 'You are root'
else
	echo 'You are not root'
fi
