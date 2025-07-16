#!/bin/bash

# * * * * THIS SCRIPT CREATE A NEW USER ON THE LOCAL SYSTEM * * * *
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password and host for the account will be displayed

# Check if the script is executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
	echo "Pleae run with sudo or root."
	exit
fi

# Get the username (login)
read -p 'Enter the username to create: ' USER_NAME

# Get the real name (contents for the description field)
read -p 'Enter the name of the person who will be using this account: ' COMMENT

# Get the password
read -p 'Enter the password for the account: ' PASSWORD

# Create the account
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then 'The account could not be created.'
	exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check if password was set
if [[ "${?}" -ne 0 ]]
then 'The password could not be set.'
        exit 1
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display the username, password, and host
echo
echo 'username: '
echo "${USER_NAME}"
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo 'hostname: '
echo "${HOSTNAME}"
exit 0
