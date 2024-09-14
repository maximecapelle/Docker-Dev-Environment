#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Function to source the correct ROS setup.bash
source_ros() {
    if [ -n "$ROS_DISTRO" ]; then
        ROS_SETUP="/opt/ros/$ROS_DISTRO/setup.bash"
        if [ -f "$ROS_SETUP" ]; then
            echo "Sourcing ROS distro: $ROS_DISTRO from $ROS_SETUP"
            source "$ROS_SETUP"
        else
            echo "Error: Could not find ROS setup file for $ROS_DISTRO at $ROS_SETUP"
        fi
    else
        echo "Error: ROS_DISTRO environment variable is not set."
    fi
}

# Source ROS
source_ros  # Correct function name

# Print OS version
OS_VERSION=$(lsb_release -d | awk -F"\t" '{print $2}')
echo -e "\n\n"
echo "OS: $OS_VERSION"

# # Print ROS version
echo "ROS$ROS_VERSION: $ROS_DISTRO"
echo -e "\n\n"

# Start an interactive shell
exec "$@"