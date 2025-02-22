FROM osrf/ros:noetic-desktop-full

ENV ROS_DISTRO=noetic
ENV DEBIAN_FRONTEND=noninteractive 


RUN apt update && \
    apt install -y curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt update && \
    apt upgrade -y


RUN apt-get install -y libgl1-mesa-glx x11-apps

ARG user_name="robogpt_user"
ARG USER_UID=1000
ARG USER_GID=1000

ENV HOME="/home/$user_name"


# Delete user if it exists in container (Ubuntu Noble: ubuntu)
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Add user_name and install sudo
RUN groupadd --gid $USER_GID $user_name && useradd --uid $USER_UID --gid $user_name --shell /bin/bash --create-home $user_name \
    && apt-get update && apt-get install -y sudo \
    && echo "$user_name ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    nano \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*


RUN chown -R $user_name:$user_name ${HOME}


ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
WORKDIR ${HOME}

# Switch to user_name user
USER $user_name

#Copying RoboGPT dependencies, real sense dependecies and python module dependecies and install
RUN mkdir -p /home/${user_name}/setup
COPY install_robogpt_dependencies.sh /home/${user_name}/setup/
COPY install_librealsense.sh /home/${user_name}/setup/
COPY requirements.txt /home/${user_name}/setup/
COPY build_robogpt_ros_pkgs.sh /home/${user_name}/setup/


#Install General RoboGPT dependencies
RUN sh /home/$user_name/setup/install_robogpt_dependencies.sh

#Install Python modules for RoboGPT
RUN pip install -r /home/$user_name/setup/requirements.txt

#Installl Realsense depedencies
RUN sh /home/$user_name/setup/install_librealsense.sh

ENTRYPOINT ["bash", "-c", "source /opt/ros/$ROS_DISTRO/setup.bash -- && exec \"$@\"", "--"]