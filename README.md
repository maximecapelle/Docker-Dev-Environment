
# Docker Dev Environment

## Overview

Welcome to **Docker Dev Environment**! This project simplifies the setup of Docker environments for development. It utilizes Docker to create a consistent development environment, complete with build and launch scripts to streamline the process.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Current Features](#current-features)
- [Coming Soon](#coming-soon)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- **yq**: Install using `sudo snap install yq`

## Getting Started

Follow these steps to get started with this project:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/maximecapelle/Docker-Dev-Environment.git docker_dev
   cd docker_dev
    ```
2. **Change the build_config.yaml file:**
Found in *config* directory:
- *build_order*: Specifies the order in which your Multi-Stage build should occur. (Note: Always start with *ubuntu* and end with *user*)
- *builds*: Sets up the different Dockerfiles, just need to specify, *name*, *dockerfile* & *build_args*.

**Make sure** to ensure that the OS versions and other installs are compatible *e.g ROS, Gazebo, Ardupilot* 

3. **Build the specified images** 

    ```bash
    cd docker_dev/scripts
    ./build.sh
    ```

4. **Change the launch_config.yaml file:**
Found in *config* directory:
- *launch*: Sets up the directories and entrypoints of the container.

**Make sure** to clearly specify the *WS_DIRECTORY_LOCAL* & *WS_DIRECTORY_CONTAINER* such that the correct directories are mounted in the correct locations.


5. **Launch the specified images** 

    ```bash
    cd docker_dev/scripts
    ./launch.sh
    ```

## Current Features
- **Linux Ubuntu:** Support for all standard Ubuntu versions. You can specify the version with the environment variable `UBUNTU_VERSION` (e.g., `22.04`). 
- **ROS1/ROS2:** Support for different ROS distributions. Specify the version with `ROS_VERSION_` (e.g., `2`) and the distribution with `ROS_DISTRO_` (e.g., `humble`).
- **Gazebo:** Integration with Gazebo for simulation.
- **PX4:** Integration with PX4.

## Coming Soon
- **Ardupilot:** Support for Ardupilot.
- **MAVROS:** Support for MAVROS for communication with MAVLink-compatible autopilots.


