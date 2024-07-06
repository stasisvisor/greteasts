#!/bin/bash

# This script checks disk usage and sends an alert if usage exceeds a specified threshold

# Function to display usage information
usage() {
    echo "Usage: $0 [threshold_percentage] [email_address]"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    usage
fi

THRESHOLD=$1
EMAIL=$2

# Check if the threshold is a valid number
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Error: Threshold must be a valid number."
    exit 1
fi

# Get the current disk usage percentage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Compare disk usage with the threshold
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    # Send an email alert
    echo "Disk usage on $(hostname) has reached $DISK_USAGE%, which is above the threshold of $THRESHOLD%." | mail -s "Disk Usage Alert" "$EMAIL"
    echo "Alert sent to $EMAIL"
else
    echo "Disk usage is within the threshold."
fi

exit 0
