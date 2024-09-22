#!/bin/bash

# Get the directory of the original script
ORIGINAL_DIR="modules/docker/scripts/"
cd "$ORIGINAL_DIR" || { echo "Failed to change directory to $ORIGINAL_DIR"; exit 1; }

# Define the path to the YAML configuration file
CONFIG_FILE="../config/build_config.yaml"
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

# Initialize the variable for the previous image
PREVIOUS_IMAGE=""
CONCATENATED_IMAGE_NAME=""

# Loop through the build order
build_order=$(yq eval '.build_order | length' "$CONFIG_FILE")
for ((i=0; i<build_order; i++)); do
    # Get the current image name from build order
    IMAGE_NAME=$(yq eval ".build_order[$i]" "$CONFIG_FILE")
    
    # Get the corresponding build configuration
    DOCKERFILE=$(yq eval ".builds[] | select(.name == \"$IMAGE_NAME\") | .dockerfile" "$CONFIG_FILE")
    BUILD_ARGS=$(yq eval ".builds[] | select(.name == \"$IMAGE_NAME\") | .build_args[]" "$CONFIG_FILE")

    # Adjust the Dockerfile path
    DOCKERFILE="../Dockerfiles/$DOCKERFILE"

    # Prepare build arguments
    ARGUMENTS=""
    for ARG in $BUILD_ARGS; do
        ARGUMENTS+=" --build-arg $ARG"
    done

    # Update the concatenated image name
    if [ -n "$CONCATENATED_IMAGE_NAME" ]; then
        CONCATENATED_IMAGE_NAME="${CONCATENATED_IMAGE_NAME}.${IMAGE_NAME}"
    else
        CONCATENATED_IMAGE_NAME="$IMAGE_NAME"
    fi

    # Add the previous image as a build argument if it's not the first image
    if [ -n "$PREVIOUS_IMAGE" ]; then
        ARGUMENTS+=" --build-arg PREVIOUS_IMAGE=$PREVIOUS_IMAGE"
    fi

    # Build the Docker image
    echo "Building: $CONCATENATED_IMAGE_NAME  ($PREVIOUS_IMAGE ----> $IMAGE_NAME) "
    echo "Running: docker build -t \"$CONCATENATED_IMAGE_NAME\" -f \"$DOCKERFILE\" $ARGUMENTS ."
    docker build -t "$CONCATENATED_IMAGE_NAME" -f "$DOCKERFILE" $ARGUMENTS .

    # Check if the build was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to build image $IMAGE_NAME!"
        exit 1
    fi

    echo "Successfully built $CONCATENATED_IMAGE_NAME"

    # Update the previous image to the current one
    PREVIOUS_IMAGE=$CONCATENATED_IMAGE_NAME
done

echo "All images built successfully!"
