#!/bin/bash

# Get the Apache log file as input.
INPUT_FILE=$1

# Create a dictionary to store the grouped data.
DATA_DICT=()

# Read the Apache log file line by line.
while read LINE; do

    # Split the line into individual fields.
    FIELDS=($LINE)

    # Get the IP address and HTTP status code from the fields.
    IP_ADDRESS=${FIELDS[0]}
    HTTP_STATUS_CODE=${FIELDS[9]}

    # Increment the counter for the corresponding IP address and HTTP status code.
    DATA_DICT[$IP_ADDRESS,$HTTP_STATUS_CODE]=$((${DATA_DICT[$IP_ADDRESS,$HTTP_STATUS_CODE]}+1))

done < "$INPUT_FILE"

# Sort the grouped data by the number of occurrences in descending order.
SORTED_DATA=$(sort -r -k 1,1 "${DATA_DICT[@]}")

# Display the grouped data in the required format.
for ITEM in $SORTED_DATA; do

    # Split the item into its individual components.
    OCCURENCE_NUMBER=$(echo $ITEM | cut -d, -f1)
    IP_ADDRESS=$(echo $ITEM | cut -d, -f2)
    HTTP_STATUS_CODE=$(echo $ITEM | cut -d, -f3)

    # Display the grouped data.
    echo "$OCCURENCE_NUMBER $IP_ADDRESS $HTTP_STATUS_CODE"

done
