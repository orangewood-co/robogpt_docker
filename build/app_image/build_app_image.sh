#!/usr/bin/env bash

#Argument default:0 [Build image with cache, this will fasten the build because the cache installed packages are installed]
#Argument 1 [Build image without cache, this will help to build robogpt image from the scratch]

#Building image from RoboGPT Dockerfile
build=1  #With cache

#Build folder name
build_folder_name="workspaces"

robogpt_version="v3"
echo "This will build an empty container with all the dependencies and packages but you still have to clone all the repos manually"
echo "press y/Y to continue or press n/N to exit."
read continue_bool

# default value is y
if [ -z "$continue_bool" ]; then
    continue_bool="y"
fi

# Check if the user wants to continue
if [[ "$continue_bool" =~ ^[yY]$ ]]; then
    echo "Continuing with the build process..."
elif [[ "$continue_bool" =~ ^[nN]$ ]]; then
    echo "Exiting the build process."
    echo "You can download the pre loaded tar file of this image"
    exit 0
else
    echo "Invalid input. Exiting the build process."
    exit 1
fi

echo "Enter Mode of Docker build, [0: with cache, 1: without cache, default:0]"
read build

echo "Enter user name you want to setup in container: [default is 'robogpt_user']"
read user_name

#Checking input is empty or not, if is empty, build=0
if [ -z "$build" ]  
then
    build=0
fi

# Set default user name if input is empty
if [ -z "$user_name" ]; then
    user_name="robogpt_user"
fi

if [ $build -eq 0 ]
    then
        echo "Building image with cache"
        docker build --build-arg USERNAME="$user_name" --build-arg ROBOGPT_VERSION=$robogpt_version -t robogpt_app .
else
    echo "Building image with no cache, it will take longer time"
    docker build --build-arg USERNAME="$user_name" --build-arg ROBOGPT_VERSION=$robogpt_version --no-cache -t robogpt_app .
fi


