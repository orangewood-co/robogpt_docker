# Use Ubuntu 20.04 latest for building RoboGPT
FROM robogpt_base:latest

# Define build-time arguments
ARG USERNAME
ARG ROBOGPT_VERSION

# Set environment variables
ENV USER_NAME_IN_HOST=$USERNAME
ENV DEBIAN_FRONTEND=noninteractive 

# Set ownership to robogpt_user user
# RUN sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Copy the necessary scripts
ADD new_dependencies.sh /home/${USERNAME}/setup/
ADD build_robogpt_ros_pkgs.sh /home/${USERNAME}/setup/

# Rename the script to match the version from the argument
# RUN mv /home/${USERNAME}/clone_robogpt_repo_${ROBOGPT_VERSION}.sh /home/${USERNAME}/clone_robogpt_repo.sh

# Set correct ownership for the added files
RUN sudo chown ${USERNAME}:${USERNAME} /home/${USERNAME}/setup/new_dependencies.sh

# Create the required directories
RUN mkdir -p /home/${USERNAME}/workspaces/ /home/${USERNAME}/orangewood_ws/

RUN sh /home/${USERNAME}/setup/new_dependencies.sh 
    
# Set the working directory inside the container
WORKDIR /home/${USERNAME}/orangewood_ws/src

#RUN sudo sudo apt-get install -y ros-noetic-ros-base ros-noetic-geometry-msgs ros-noetic-roscpp ros-noetic-rospy ros-noetic-moveit-commander ros-noetic-realsense2-camera
# Update, fix dependencies, and install packages
RUN sudo apt-get update && \
    sudo apt-get --fix-broken install -y && \
    sudo apt-get install -y debconf-utils \
        ros-noetic-robot-state-publisher \
        ros-noetic-rviz \
        ros-noetic-xacro \
        ros-noetic-moveit

# Add more packages if needed

# Set the working directory
WORKDIR /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk

# Run the necessary scripts, chaining them to avoid errors
RUN  sh /home/${USERNAME}/setup/build_robogpt_ros_pkgs.sh

# Set the working directory
WORKDIR /home/${USERNAME}/orangewood_ws

# RUN sudo chmod -R a+w /opt/ros/noetic/share/robogpt_agents/config/tools_config/

# Switch to nivo user
USER ${USERNAME}

# Source ROS environment, resolve dependencies, and build the workspace
#RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
#    rosdep install --from-paths src --ignore-src -r -y && \
#    catkin_make -j1"


RUN sudo apt install debconf-utils -y
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration

RUN sudo pip install -U rosdep

RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    catkin_make"

# Source the workspace setup
RUN echo "source /home/${USERNAME}/orangewood_ws/devel/setup.bash" >> ~/.bashrc

ADD pusher.json /home/${USERNAME}/.config/

# Create workspace directory

CMD ["/bin/bash"]
