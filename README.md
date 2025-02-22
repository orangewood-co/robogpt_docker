# Docker for Robot GPT

This repository contains a Dockerfile and a shell script to build a Docker image for RoboGPT and start running RoboGPT on the local machine. This repo is strictly for development.

# Prerequisites for your PC

* Docker on Ubuntu/Mac/Windows. You can set up Ubuntu on a VM or a real machine.
* A little knowledge of Git, Docker, and SSH key setup.

These underlying steps of basic Git are for someone who is not from the software team. And if you are from the software team and need these steps, bro, go study!

## Adding SSH Keys to your GitHub account

This is very important. Make sure you have your Orangewood email ID, e.g., name@orangewood.co.

You can first create a GitHub account if you don't have one.

## Create an SSH Key on your PC

The following command helps you create the SSH public key on your Ubuntu machine.

```
ssh-keygen
```
Enter the following command to see the public key:

```
cat ~/.ssh/id_rsa.pub
```

You can see the key like this:

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6jneukND+5FOtT7ouLtH7lb5xtJHX7f+x7RhSqJkMmzHIbHiHku4UP0alXeg43P/9ew98xoikvVN0Al4Z9C/otpp0ECVUnKmhpyH4io1q4Rwa7juzkb7IWH7jbGpkU3kCnhIf4LxjYvj9cncUVDN/F8GvAnSFiuPH0JMIbX5OOrfeZW4VIU8Jbmus7e6lA4cnyM31PJsAsCOTkDX1VZKc6RDLqeR5qTemw5c+ivBWl2YzybYvofjVZ5HzothluIGXwWMeNRsZE/f/IHFaDzqYEOc3V2LCnZaMkxSp9PsK4gAAQEYERavhO93w8PGoAGmrx0wfJ2yu9KPCRuKftV2MzrzcgxdPaG3kdg8HR4uLVYy0HKWhwCsnpWHP9BFRsSn12dxJGEnIWa8sHTZawtRngy5w1SM5n1tsQATDYq3fV8nU7YfTk+vFMskjnxIS2opC9VAVM/8BJrDWvIx6tM9Nz+sj0BwHDmkBkEFQ+sJgNoBrGtEdoowc3hJXpeyUAG0= robogpt@ubuntu
```

Go to the [SSH keys](https://github.com/settings/keys) section of your GitHub account, copy-paste this key, and add it to your account.

This will help you clone the Orangewood repository without using access tokens.

Congratulations, you have successfully set up SSH access.

--------------------------------------------

## Setup Docker for RoboGPT Repository on Host Machine

To start RoboGPT using Docker, you must first clone/download the robogpt_docker repository on your machine. This repository has a Dockerfile and scripts to build the Docker image for the RoboGPT app.

To clone the repository on your machine, open a terminal and install Git on your host machine. You can use the following commands to do this:

```
sudo apt update

sudo apt install git
```

Once you have installed *Git*, you can start cloning this repository using the following command.

Note: **You can clone the repository in your HOME folder**

```
git clone git@github.com:orangewood-co/robogpt_docker.git
```
If you have already cloned the repository, you can use the following command to get the latest update of docker_robogpt:

```
cd ~/robogpt

git pull  # for latest updates
```

## Installing Docker on the Host Machine

To install Docker on the host machine, there is a ready-made script available in the repository.

Open the terminal, and navigate inside the docker_robogpt repository:

```
cd ~/robogpt/setup
```

Execute the ready-made shell script to install Docker on your machine:

```
chmod +x setup_host_machine.sh

./setup_host_machine.sh
```

This will install Docker automatically on your machine.

**Note: REBOOT YOUR MACHINE AFTER INSTALLING DOCKER**

# Here comes the catch: we now have two images
* robogpt_base: This one contains all the base files, dependencies, and ROS packages needed to run RoboGPT.
* robogpt_app: This contains the main codebase of RoboGPT.

## Method 1: Building both the base and app images

Here is how we can build both images.

```
cd ~/robogpt/build/base_image

./build_base_image.sh 
```
This will take around 10 to 20 minutes to complete. You can choose 0 for a cached build and 1 for a non-cached build, which is slower, but 1 is RECOMMENDED if there are any new dependencies.

After building the base image, build the app image:

```
cd ~/robogpt/build/app_image/

./build_app_image.sh 
```
This will take around 10 to 20 minutes to complete. You can choose 0 for a cached build and 1 for a non-cached build, which is slower, but 1 is RECOMMENDED if there are any new dependencies.

Now we can start the container:

```
cd robogpt/run

./start_container.bash 
```
The major difference is you have to manually clone the repos inside this container when you build for now. But it comes preinstalled with a tar file.

## Method 2: Build the base image (This is inevitable) and download the tar file of the RoboGPT app image

Same steps for base_image. For downloading the tar file [press softly](https://lol.com/).

```
# Go to the folder where you downloaded this file
docker load -i robogpt_app.tar
```
Wait for the image to load. This may take some time depending on your computer or skills.

Now we can start executing the RoboGPT bringup commands inside the container.

## Checking if the Container and Image are Running

To check if the container is running:

```
docker ps -a
```

To check if the image is available:
```
docker images --all
```
You should see robogpt_base and robogpt_app here. If not, you might have done something wrong. Try again or contact the team.

## Opening Multiple Instances of the Same Container

To open another terminal instance in an existing container, run:

```
docker exec -it robogpt_app /bin/bash
```

## Stopping and Removing Containers and Images

Stop all running containers:
Remove all stopped containers:
Remove all Docker images:

```
docker stop $(docker ps -q)

docker rm $(docker ps -aq)

docker rmi $(docker images -q)
```

## Pruning All Docker Data

To remove all Docker data from the system, including volumes:

```
docker system prune -a --volumes
```
