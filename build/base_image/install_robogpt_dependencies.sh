#!/usr/bin/env bash

echo "Installing RoboGPT dependencies"

apt update

apt install -y software-properties-common \
                    curl \
                    python3-pip \
                    mosquitto \
                    mosquitto-clients \
                    openssh-server \
                    openssh-client \
                    git \
                gnome-terminal \
                terminator \
                apt-utils

#ROS Depedencies
apt install  -y ros-noetic-moveit \
                ros-noetic-prbt-hardware-support \
                ros-noetic-moveit-commander \
                
                

echo "Done installing RoboGPT dependencies"
