#!/usr/bin/env bash

# USER_NAME_HOST=$(whoami)
# DEFAULT_HOME_PATH="/home/$USER_NAME_HOST"

# echo "Start installing new roboGPT depedencies"
# cd /home/robogpt_user/workspaces

# echo "Done with new RoboGPT depedencies"

# ###########################################################

# rosdep init

# rosdep update

# echo $DEFAULT_HOME_PATH

# ROS_WORKSPACE_PATH=/home/robogpt_user/workspaces/robogpt/robogpt_ws

# echo $ROS_WORKSPACE_PATH

# cd $ROS_WORKSPACE_PATH

# rosdep install --from-paths src --ignore-src -y --rosdistro noetic

# catkin_make

# source $ROS_WORKSPACE_PATH/devel/setup.bash

#Building owl client here

cd /home/robogpt_user/orangewood_ws/src/robot_drivers/SDK/owl_6.5_sdk
sudo pip3 install -e .

# sudo service mosquitto start

# cd $DEFAULT_HOME_PATH/workspaces/robogpt

# bash
