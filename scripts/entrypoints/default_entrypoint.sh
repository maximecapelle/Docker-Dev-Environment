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

# # Print PX4 Firmware
if [ -n "$PX4_INSTALLED" ]; then
    echo "PX4: Installed"
    # Check if the symbolic link already exists
    if [ ! -L /ros2_ws/PX4-Autopilot ]; then
        ln -s /setup_ws/PX4/PX4-Autopilot /ros2_ws/PX4-Autopilot
    fi
fi

# # Print QGroundControl
if [ -n "$QGC_INSTALLED" ]; then
    echo "QGroundControl: Installed"
    # Check if the symbolic link already exists
    if [ ! -L /ros2_ws/QGroundControl.AppImage ]; then
        ln -s /app/QGroundControl.AppImage /ros2_ws/QGroundControl.AppImage
    fi
fi

echo -e "\n\n"
# Start an interactive shell
exec "$@"