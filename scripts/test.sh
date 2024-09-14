#!/bin/bash

# Define the path to the YAML configuration file
CONFIG_FILE="build_config.yml"

# Check if the YAML configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found!"
    exit 1
fi

echo "Configuration file found: $CONFIG_FILE"

# Proceed with the rest of the script
# ...
