# Docker Dev Environment

## Overview

Welcome to **Docker Dev Environment**! This project is designed to ease the setup of the docker environments for development. It uses Docker to create a consistent development environment, including build and launch scripts to streamline the process.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Current Dockerfiles](#)

## Prerequisites

Ensure you have the following installed on your machine:

- [Docker](https://docs.docker.com/get-docker/)
- **yq** (sudo snap install yq)

## Getting Started

To get started with this project, follow these steps:

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

## Dockerfiles
**Current**
- Linux Ubuntu: All standard ubuntu versions, version can be specified with: e.g *UBUNTU_VERSION=22.04* 
- ROS1/ROS2: Distributions can be specified with: e.g *ROS_VERSION_=2 & ROS_DISTRO_=humble*
**COMING**
- Gazebo
- Ardupilot
- PX4
- MAVROS


