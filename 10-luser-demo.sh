#!/bin/bash

log() {
	# This function sends a message to syslog and to STDOUT if VERBOSE is true
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true'  ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file() {
	# This function creates a backup file. Returns non-zero status on error
	local FILE="${1}"

	# Make sure the file exists
	if [[ -f "${FILE}"  ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
	log "Backing up ${FILE} to ${BACKUP_FILE}"

	# Exit status of function will be exit status of cp command
	cp -p ${FILE} ${BACKUP_FILE}
	else 
		# The file does not exist, return a non-zero exit status
		return 1
	fi
}

readonly VERBOSE='true'
log 'Hello!'
log 'This is fun'
backup_file '/etc/passwd'

if [[ "${?}" -eq '0' ]]
then
	log 'File backup succeeded!'
else
	log 'File backup failed'
	exit 1
fi
