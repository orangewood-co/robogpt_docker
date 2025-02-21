#!/usr/bin/env bash



#Argument default:0 [Build image with cache, this will fasten the build because the cache installed packages are installed]
#Argument 1 [Build image without cache, this will help to build robogpt image from the scratch]

#Building image from RoboGPT Dockerfile
build=1  #With cache

#Build folder name
build_folder_name="workspaces"

robogpt_version="v3"

#echo "Cloning RoboGPT Repository"
#sh clone_robogpt_repo.sh
#echo "RoboGPT Repository clonned successfully"


echo "Enter Mode of Docker build, [0: with cache, 1: without cache, default:0]"
read build

#Checking input is empty or not, if is empty, build=0
if [ -z "$build" ]  
then
    build=0
    fi


if [ $build -eq 0 ]
    then
        echo "Building image with cache"
        docker build --build-arg USERNAME=$(whoami) --build-arg ROBOGPT_VERSION=$robogpt_version -t robogpt_app .
else
    echo "Building image with no cache, it will take longer time"
    docker build --build-arg USERNAME=$(whoami) --build-arg ROBOGPT_VERSION=$robogpt_version --no-cache -t robogpt_app .
fi

#Running RoboGPT instance from image

#Make sure following folders present in the host PC, we are using this packages in host and build it in docker

#~/workspaces/robogpt/robogpt-core/
# ~/workspaces/robogpt/robogpt-description/
# ~/workspaces/robogpt/robogpt-moveit/


