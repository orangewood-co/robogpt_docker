#! /bin/sh

docker login

docker tag librealsense/librealsense:latest orangewoodlabs/librealsense:latest
docker push orangewoodlabs/librealsense:latest