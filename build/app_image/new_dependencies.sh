#!/usr/bin/env bash


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
        ros-noetic-roscpp \
        ros-noetic-rospy \
        ros-noetic-catkin \
        ros-noetic-moveit-commander \
        python3-tk \
    && apt-get clean



# Add new dependencies here
# Eg: apt install htop

#Pushered need to install from .deb
#Need to login pusher via command line
# pusher login
# Key: ovKvhW_12Ys3d_i_OXdj_OWlXNXaByEA47F7A4L4nag

sudo apt install -y wget curl
sudo chown -R _apt:robogpt_user /var/lib/apt/lists
wget https://github.com/pusher/cli/releases/download/v0.20/pusher_0.20_linux_amd64.deb -P /home/robogpt_user -O pusher.deb
cd /home/robogpt_user
sudo apt install -y /home/robogpt_user/pusher.deb


pip3 install azure.storage.blob
pip3 install azure-storage-file-share

#curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
#sudo apt install -y nodejs npm
#sudo apt install -y firefox
#New one
# sudo apt install -y ros-noetic-moveit-commander
# sudo -H pip install owl_robot_sdk
