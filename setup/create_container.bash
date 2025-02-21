#!/usr/bin/env bash


echo "Cloning RoboGPT app"  #This will clone each repos of particular branch
cd app_image

#RoboGPT core branch
#robogpt_core_branch=demo_owl_6.5
robogpt_core_branch=owl_sim

#Robot description branch
robo_description_branch=devel

#Robot moveit branch
robo_moveit_branch=master

#Owlclient repo
owl_client_branch=main

#RoboGPT front end app
robot_gpt_frontend_branch=main

#sh clone_robogpt_repo.sh $robogpt_core_branch $robo_description_branch $robo_moveit_branch $owl_client_branch $robot_gpt_frontend_branch    
#echo "Cloned RoboGPT"

echo "Building RoboGPT app"
sh build_app_image.sh
echo "Built RoboGPT app image"
xhost +local:docker 


docker run -it \
    --name="robogpt_app" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/home/$USER:/home/$USER" \
    --device=/dev/video0:/dev/video0 \
    --device=/dev/video1:/dev/video1 \
    --device=/dev/video2:/dev/video2 \
    --device=/dev/bus/usb:/dev/bus/usb \
    --privileged \
    robogpt_app \
    bash 

#    bash /home/robogpt_user/build_robogpt_ros_pkgs.sh $USER
