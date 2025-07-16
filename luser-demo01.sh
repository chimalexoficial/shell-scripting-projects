#!/bin/bash

# Display hello
echo 'Hello'

# Assign a value to a variable
WORD='script'

# Display that value using the variable
echo "$WORD"

# WORD variable not working with single quotes

echo '$WORD'

# combine the variable with hard-coded text
echo "This is a shell $WORD"

# Using curly braces
echo "This is a shell ${WORD} printing in the file with curly braces"

# Append text to a variable
echo "${WORD}ing is fun!"

# Show how NOT to appende text to a variable
# This doesn't work
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'

# Combine two variables
echo "This is ${WORD}${ENDING}"

# Change the value stored in the ENDING variable
ENDING='ing'
echo "${WORD}${ENDING} is fun"

# Reassing value to ENDING
ENDING='s'
echo "You are going to write many scripts in this class!"
