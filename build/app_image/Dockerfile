# Use Ubuntu 20.04 latest for building RoboGPT
FROM robogpt_base:latest

# Define build-time arguments
ARG USERNAME
ARG ROBOGPT_VERSION

# Set environment variables
ENV USER_NAME_IN_HOST=$USERNAME
ENV DEBIAN_FRONTEND=noninteractive 

# Set ownership to robogpt_user user
RUN sudo chown -R robogpt_user:robogpt_user /home/robogpt_user

# Copy the necessary scripts
ADD new_dependencies.sh /home/robogpt_user/
ADD clone_robogpt_repo_*.sh /home/robogpt_user/

# Rename the script to match the version from the argument
RUN mv /home/robogpt_user/clone_robogpt_repo_${ROBOGPT_VERSION}.sh /home/robogpt_user/clone_robogpt_repo.sh

# Set correct ownership for the added files
RUN sudo chown robogpt_user:robogpt_user /home/robogpt_user/clone_robogpt_repo.sh /home/robogpt_user/new_dependencies.sh

# Create the required directories
RUN mkdir -p /home/robogpt_user/workspaces/ /home/robogpt_user/orangewood_ws/



RUN sh /home/robogpt_user/new_dependencies.sh && \
    sh /home/robogpt_user/clone_robogpt_repo.sh

    
# # Copy the .deb files to the container
# COPY ros-noetic-robogpt-agents_0.0.0-0focal_amd64.deb /home/robogpt_user/orangewood_ws/src/
# COPY ros-noetic-robogpt-bringup_0.0.0-0focal_amd64.deb /home/robogpt_user/orangewood_ws/src/
# COPY ros-noetic-robogpt-vision_0.0.0-0focal_amd64.deb /home/robogpt_user/orangewood_ws/src/
# COPY ros-noetic-robot-drivers_0.0.0-0focal_amd64.deb /home/robogpt_user/orangewood_ws/src/
# COPY ros-noetic-robogpt-apps_0.0.0-0focal_amd64.deb /home/robogpt_user/orangewood_ws/src/


# #Install .deb packages
# RUN sudo dpkg -i /home/robogpt_user/orangewood_ws/src/ros-noetic-robogpt-agents_0.0.0-0focal_amd64.deb \
#     && sudo apt-get install -f -y \
#     && sudo dpkg -i /home/robogpt_user/orangewood_ws/src/ros-noetic-robogpt-bringup_0.0.0-0focal_amd64.deb \
#     && sudo apt-get install -f -y \
#     && sudo dpkg -i /home/robogpt_user/orangewood_ws/src/ros-noetic-robogpt-vision_0.0.0-0focal_amd64.deb \
#     && sudo apt-get install -f -y \
#     && sudo dpkg -i /home/robogpt_user/orangewood_ws/src/ros-noetic-robot-drivers_0.0.0-0focal_amd64.deb \
#     && sudo apt-get install -f -y \
#     && sudo dpkg -i /home/robogpt_user/orangewood_ws/src/ros-noetic-robogpt-apps_0.0.0-0focal_amd64.deb \
#     && sudo apt-get install -f -y \
#     && sudo apt-get clean

# Set the working directory inside the container
WORKDIR /home/robogpt_user/orangewood_ws/src

# Copy all .deb files from the local Release_files directory into the container
COPY Release_files/*.deb /home/robogpt_user/orangewood_ws/src/

# Install all .deb files
RUN for deb_file in /home/robogpt_user/orangewood_ws/src/*.deb; do \
    sudo dpkg -i "$deb_file" || true; \
    sudo apt-get install -f -y; \
    sudo apt-get clean; \
done

#RUN sudo sudo apt-get install -y ros-noetic-ros-base ros-noetic-geometry-msgs ros-noetic-roscpp ros-noetic-rospy ros-noetic-moveit-commander ros-noetic-realsense2-camera
# Update, fix dependencies, and install packages
RUN sudo apt-get update && \
    sudo apt-get --fix-broken install -y && \
    sudo apt-get install -y debconf-utils \
        ros-noetic-robot-state-publisher \
        ros-noetic-rviz \
        ros-noetic-xacro

# Set the working directory
WORKDIR /opt/ros/noetic/share/robot_drivers/SDK/owl_6.5_sdk

# Run the necessary scripts, chaining them to avoid errors
RUN  sh /home/robogpt_user/build_robogpt_ros_pkgs.sh

# Set the working directory
WORKDIR /home/robogpt_user/orangewood_ws

RUN sudo chmod -R a+w /opt/ros/noetic/share/robogpt_agents/config/tools_config/


# Switch to nivo user
USER robogpt_user

# Source ROS environment, resolve dependencies, and build the workspace
#RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
#    rosdep install --from-paths src --ignore-src -r -y && \
#    catkin_make -j1"


RUN sudo apt install debconf-utils -y
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration


RUN sudo pip install -U rosdep

#RUN sudo rosdep init

RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    catkin_make"

# Source the workspace setup
RUN echo "source /home/robogpt_user/orangewood_ws/devel/setup.bash" >> ~/.bashrc

ADD pusher.json /home/robogpt_user/.config/

# Create workspace directory

CMD ["/bin/bash"]
