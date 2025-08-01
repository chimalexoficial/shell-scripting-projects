#!/bin/bash


# This script creates a new user on the local system.
# You must supply a username as an argument to the script
# Optionally, you can also provide a comment for the account as an argument
# A password will be automatically generated for the account
# The username, password and host for the account will be displayed



# Make sure the script is being executed with superuser

if [[ "$UID" -ne 0 ]]
then
	echo "You don't have super user power. Use sudo or root. Exiting..."
	exit 1
fi

# If they don't supply at least one argument, then give them help
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..."
	echo "Create an account on the local system with the name of USER_NAME and a comments fields of COMMENTS"
	exit 1
fi

# The first parameter is the username
USER_NAME="${1}"

# The rest of the parameters are for the account comments
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check if user was created with status of command
if [[ "${?}" -ne 0 ]]
then
	echo "The account could not be created"
	exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check is last command suceeded
if [[ "${?}" -eq 0 ]]
then
	echo "The password could not be set"
	exit 1
fi

# Force password change
passwd -e ${USER_NAME}

# Display info
echo
echo "username: "
echo "${USER_NAME}"
echo
echo "password: "
echo "${PASSWORD}"
echo
echo "host: "
echo "${HOSTNAME}"
exit 0


