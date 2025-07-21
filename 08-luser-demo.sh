#!/bin/bash

# This script is for I/O redirection

# Redirect STDOUT to a file
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the file
head -n3 /etc/passwd > ${FILE}
echo
echo "Contens of ${FILE}"
cat ${FILE}

# Redirect STOUT to a file appendng to the file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}: "
cat ${FILE}

# Redirect STDIN to a program, using File Descriptor
read LINE 0< ${FILE}
echo
echo "Line contains: ${LINE}"

# Redirect STDOUT to a file using File Descriptor 1, overwriting the file
head -n3 /etc/passwd 1> ${FILE}
echo 
echo "Contents of file ${FILE}"
cat ${FILE}

# Redirect STDERR to a file using a FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd/fakefile 2> ${ERR_FILE}

# Redirect the STDOUT and STERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

# Redirect STDOUT and STDERR trough a pipe
echo 
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
echo "This is STDERR!!" >&2

# Discard STDOUT
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STERR
echo "Discarding STDERR"
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo "Discarding STDOUT and STDERR"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null

