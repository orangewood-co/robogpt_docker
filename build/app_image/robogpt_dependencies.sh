#!/usr/bin/env bash

# Installing robogpt dedicated packages 
RUN apt-get update \
    && apt-get install -y \
        ros-noetic-realsense2-camera \
        curl \
        lsb-release \
        gnupg2 \
        ca-certificates \
        wget \
        apt-transport-https \
        gnupg \
        build-essential \
        dpkg \
        ros-noetic-geometry-msgs \
        ros-noetic-robot-state-publisher \
        ros-noetic-rviz \
        ros-noetic-xacro \
        ros-noetic-roscpp \
        ros-noetic-rospy \
        ros-noetic-catkin \
        ros-noetic-moveit-commander \
        ros-noetic-joint-trajactory \
        ros-noetic-rviz-visual-tools \
        ros-noetic-moveit-visual-tools \
        python3-tk \
    && apt-get clean

# Add more packages above if needed

# Installing pusher 
sudo apt install -y wget curl
sudo chown -R _apt:$(whoami) /var/lib/apt/lists
wget https://github.com/pusher/cli/releases/download/v0.20/pusher_0.20_linux_amd64.deb -P /home/$(whoami) -O pusher.deb
cd /home/$(whoami)
sudo apt install -y /home/$(whoami)/pusher.deb


