#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# FUNCTIONS
source_ros() {
    if [ -n "$ROS_DISTRO" ]; then
        ROS_SETUP="/opt/ros/$ROS_DISTRO/setup.bash"
        if [ -f "$ROS_SETUP" ]; then
            # echo "Sourcing ROS distro: $ROS_DISTRO from $ROS_SETUP"
            source "$ROS_SETUP"
        else
            echo "Error: Could not find ROS setup file for $ROS_DISTRO at $ROS_SETUP"
        fi
    fi
}



## PRINTING VERSIONS
echo -e "\n\n"

# Print OS version
OS_VERSION=$(lsb_release -d | awk -F"\t" '{print $2}')
if [ -n "$OS_VERSION" ]; then
    echo "OS: $OS_VERSION"
fi

# # Print ROS version
if [ -n "$ROS_DISTRO" ]; then
    # Source ROS
    source_ros  # Correct function name
    echo "ROS$ROS_VERSION: $ROS_DISTRO"
fi

# # Print Gazebo Environment
if [ -n "$GAZEBO_VERSION" ]; then
    echo "Gazebo: $GAZEBO_VERSION"
fi



echo -e "\n\n"
# Start an interactive shell
exec "$@"