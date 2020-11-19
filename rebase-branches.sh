#!/bin/sh
# SPDX-FileCopyrightText: 2020 Smart Robotics Lab, Imperial College London
# SPDX-FileCopyrightText: 2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

set -u
IFS="$(printf '%b_' '\t\n')"; IFS="${IFS%_}"

# Ubuntu 20.04
git branch --force ubuntu2004 master

# ROS Noetic
git branch --force ros-noetic master
git checkout ros-noetic
sed --in-place 's/ARG BASE_IMAGE=ubuntu:20\.04/ARG BASE_IMAGE=ros:noetic-ros-base-focal/' Dockerfile-CI
git add Dockerfile-CI
git commit --message 'Change default image to ROS Noetic on Ubuntu 20.04'

# Ubuntu 18.04
git branch --force ubuntu1804 master
git checkout ubuntu1804
sed --in-place 's/ARG BASE_IMAGE=ubuntu:20\.04/ARG BASE_IMAGE=ubuntu:18\.04/' Dockerfile-CI
git add Dockerfile-CI
git commit --message 'Change default image to Ubuntu 18.04'

# ROS Melodic
git branch --force ros-melodic master
git checkout ros-melodic
sed --in-place 's/ARG BASE_IMAGE=ubuntu:20\.04/ARG BASE_IMAGE=ros:melodic-ros-base-bionic/' Dockerfile-CI
git add Dockerfile-CI
git commit --message 'Change default image to ROS Melodic on Ubuntu 18.04'

git checkout master

# Force push the branches
if [ "$#" -eq 1 ] && [ "$1" = 'push' ]; then
	git push --force origin master:master
	git push --force origin ubuntu2004:ubuntu2004
	git push --force origin ros-noetic:ros-noetic
	git push --force origin ubuntu1804:ubuntu1804
	git push --force origin ros-melodic:ros-melodic
fi

