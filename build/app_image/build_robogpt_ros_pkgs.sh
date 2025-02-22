#!/bin/bash

# This script will install RoboGPT dependencies and build the required SDK

# Update paths to the new location of the SDK
echo "Installing dependencies for RoboGPT"

# Navigate to the correct SDK directory
cd /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk

# Install the package using pip3 (no editable mode)
echo "Installing owl_6.5_sdk"
sudo pip3 install /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk


echo "RoboGPT dependencies installed successfully"
