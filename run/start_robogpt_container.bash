#!/usr/bin/env bash

CONTAINER_NAME="robogpt_app" #name of container which you created earlier, by running "create_container.sh" file.

# Enable access control for X server to avoid GUI issues
xhost +local:docker

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
XAUTH_DOCKER=/tmp/.docker.xauth

# Create Xauth if not present
if [ ! -f $XAUTH ]; then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]; then
        echo "$xauth_list" | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it --name "$CONTAINER_NAME" --device=/dev/bus/usb --privileged -e DISPLAY="$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix "$CONTAINER_NAME":latest /bin/bash
