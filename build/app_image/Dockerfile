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
ADD robogpt_dependencies.sh /home/${USERNAME}/setup/

# Rename the script to match the version from the argument
# RUN mv /home/${USERNAME}/clone_robogpt_repo_${ROBOGPT_VERSION}.sh /home/${USERNAME}/clone_robogpt_repo.sh

# Set correct ownership for the added files
RUN sudo chown ${USERNAME}:${USERNAME} /home/${USERNAME}/setup/robogpt_dependencies.sh

# Create the required directories
RUN mkdir -p /home/${USERNAME}/workspaces/ /home/${USERNAME}/orangewood_ws/

RUN sh /home/${USERNAME}/setup/robogpt_dependencies.sh
    
# Set the working directory inside the container
WORKDIR /home/${USERNAME}/orangewood_ws/src

# Set the working directory
WORKDIR /home/${USERNAME}/orangewood_ws

# Switch to nivo user
USER ${USERNAME}

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

ENTRYPOINT ["bash", "-c", "source /opt/ros/$ROS_DISTRO/setup.bash -- && source ~/orangewood_ws/devel/setup.bash && exec \"$@\"", "--"]

CMD ["/bin/bash"]