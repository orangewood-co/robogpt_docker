#!/bin/bash

# This script will install RoboGPT dependencies and build the required SDK

# Update paths to the new location of the SDK
echo "Installing dependencies for RoboGPT"

# Navigate to the correct SDK directory
cd /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk

# Install the package using pip3 (no editable mode)
echo "Installing owl_6.5_sdk"
sudo pip3 install /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk

# Make sure all other scripts are executable if needed
# chmod +x some_other_script.sh   # Uncomment this if you have other scripts to make executable

# Start necessary services if required
# sudo service mosquitto start    # Uncomment if needed for MQTT services

# If you need to source your ROS workspace, do it here (optional based on your setup)
# cd $ROS_WORKSPACE_PATH
# source $ROS_WORKSPACE_PATH/devel/setup.bash

echo "RoboGPT dependencies installed successfully"
