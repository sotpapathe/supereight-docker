#!/usr/bin/sh
# SPDX-FileCopyrightText: 2019-2020 Smart Robotics Lab, Imperial College London
# SPDX-FileCopyrightText: 2019-2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

set -eu
IFS="$(printf '%b_' '\t\n')"; IFS="${IFS%_}"

usage() {
	name='build.sh'
	echo "Usage: $name ci"
	echo "       $name test"
	echo "       $name push-ci"
	echo "       $name clean"
	echo "       $name run-ci [TAG]"
	echo "       $name run-test [TAG]"
}

# Parse the command line arguments
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
	usage
	exit 1
fi
command="$1"
tag='latest'
case "$command" in
	'ci'|'test'|'push-ci'|'clean')
		# These commands accept a single argument
		if [ "$#" -ne 1 ]; then
			usage
			exit 1
		fi
		;;

	'run-ci'|'run-test')
		# Get the command argument if provided
		if [ "$#" -eq 2 ]; then
			tag="$2"
		fi
		;;
	*)
		# Unknown command
		usage
		exit 1
		;;
esac

# Run the appropriate command
case "$command" in
	'ci')
		docker image build --file Dockerfile \
				--build-arg BASE_IMAGE=ubuntu:20.04 \
				--tag sotirisp/supereight-ci:20.04 \
				--tag sotirisp/supereight-ci:latest .
		echo '# Ubuntu 20.04 image built #####################################'
		docker image build --file Dockerfile \
				--build-arg BASE_IMAGE=ros:noetic-ros-base-focal \
				--tag sotirisp/supereight-ci:ros-noetic .
		echo '# ROS Noetic image built #######################################'
		docker image build --file Dockerfile \
				--build-arg BASE_IMAGE=ubuntu:18.04 \
				--tag sotirisp/supereight-ci:18.04 .
		echo '# Ubuntu 18.04 image built #####################################'
		docker image build --file Dockerfile \
				--build-arg BASE_IMAGE=ros:melodic-ros-base-bionic \
				--tag sotirisp/supereight-ci:ros-melodic .
		echo '# ROS Melodic image built ######################################'
		;;

	'test')
		SSH_PRIVATE_KEY=$(cat /home/"$(logname)"/.ssh/git_readonly_key)
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:20.04 \
				--tag sotirisp/supereight-ci:20.04-test \
				--tag sotirisp/supereight-ci:latest-test .
		echo '# Ubuntu 20.04 test image built ################################'
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:ros-noetic \
				--tag sotirisp/supereight-ci:ros-noetic-test .
		echo '# ROS Noetic test image built ##################################'
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:18.04 \
				--tag sotirisp/supereight-ci:18.04-test .
		echo '# Ubuntu 18.04 test image built ################################'
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:ros-melodic \
				--tag sotirisp/supereight-ci:ros-melodic-test .
		echo '# ROS Melodic test image built #################################'
		docker rmi -f "$(docker images -q --filter label=stage=intermediate)"
		;;

	'push-ci')
		docker push sotirisp/supereight-ci:latest
		docker push sotirisp/supereight-ci:20.04
		docker push sotirisp/supereight-ci:ros-noetic
		docker push sotirisp/supereight-ci:18.04
		docker push sotirisp/supereight-ci:ros-melodic
		;;

	'clean')
		printf '\033[1;31mCAUTION\033[m: This will affect all docker images/containers, not just the supereight ones\n'
		echo "Press [Enter] to continue or [Ctrl+C] to cancel"
		read -r _
		docker rmi -f "$(docker images -q --filter label=stage=intermediate)"
		docker container prune
		docker image prune
		;;

	'run-ci')
		docker run --tty --interactive --rm sotirisp/supereight-ci:"$tag"
		;;

	'run-test')
		docker run --tty --interactive --rm sotirisp/supereight-ci:"$tag"-test
		;;
esac

