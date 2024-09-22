#!/bin/bash
ORIGINAL_DIR="modules/docker/scripts/"
cd "$ORIGINAL_DIR" || { echo "Failed to change directory to $ORIGINAL_DIR"; exit 1; }

CONFIG_FILE="../config/launch_config.yaml"
echo "Current directory: $(pwd)"

# Check if the YAML configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found!"
    exit 1
fi

# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "yq could not be found. Please install yq to continue."
    echo -e "use command: \n sudo snap install yq"
    exit 1
fi

# Load in launch arguments
IMAGE_NAME=$(yq eval '.launch[0].IMAGE_NAME' "$CONFIG_FILE")
WS_DIRECTORY_LOCAL=$(yq eval '.launch[1].WS_DIRECTORY_LOCAL' "$CONFIG_FILE")
WS_DIRECTORY_CONTAINER=$(yq eval '.launch[2].WS_DIRECTORY_CONTAINER' "$CONFIG_FILE")
ENTRYPOINT_PATH=$(yq eval '.launch[3].ENTRYPOINT_PATH' "$CONFIG_FILE")
SCRIPTS=$(basename "$(pwd)")


# Check if the Docker image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo "Error: Docker image '$IMAGE_NAME' not found!"
    exit 1
fi

# Run the Docker container with interactive terminal
echo "Launching Docker container: $IMAGE_NAME"
xhost +local:root
docker run -it \
    --rm \
    --name dev_container \
    --privileged \
    --volume "$HOME/$WS_DIRECTORY_LOCAL":"$WS_DIRECTORY_CONTAINER" \
    --volume "$(pwd):/$SCRIPTS" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -w "$WS_DIRECTORY_CONTAINER" \
    -e DISPLAY \
    --entrypoint "$ENTRYPOINT_PATH" \
    "$IMAGE_NAME" bash