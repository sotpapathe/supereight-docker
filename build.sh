#!/usr/bin/sh
# SPDX-FileCopyrightText: 2019-2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

set -eu
IFS="$(printf '%b_' '\t\n')" ; IFS="${IFS%_}"

usage() {
	echo "Usage: $(basename "$0") build-ci|build-test|run-ci|run-test|push-ci"
}

# Ensure only one argument was supplied
if [ "$#" -ne 1 ] ; then
	usage
	exit 1
fi

# Perform the appropriate action
case "$1" in
	'build-ci')
		docker image build --file Dockerfile-CI \
				--build-arg BASE_IMAGE=ubuntu:20.04 \
				--tag sotirisp/supereight-ci:20.04 \
				--tag sotirisp/supereight-ci:latest .
		echo '# Ubuntu 20.04 image built #####################################'
		docker image build --file Dockerfile-CI \
				--build-arg BASE_IMAGE=ubuntu:18.04 \
				--tag sotirisp/supereight-ci:18.04 .
		echo '# Ubuntu 18.04 image built #####################################'
		docker image build --file Dockerfile-CI \
				--build-arg BASE_IMAGE=ros:melodic-ros-base-bionic \
				--tag sotirisp/supereight-ci:ros-melodic .
		echo '# ROS Melodic image built ######################################'
		;;

	'run-ci')
		docker run --tty --interactive --rm sotirisp/supereight-ci:latest
		;;

	'build-test')
		SSH_PRIVATE_KEY=$(cat /home/$(logname)/.ssh/git_readonly_key)
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:20.04 \
				--tag sotirisp/supereight-ci:20.04-test \
				--tag sotirisp/supereight-ci:latest-test .
		echo '# Ubuntu 20.04 test image built ################################'
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:18.04 \
				--tag sotirisp/supereight-ci:18.04-test .
		echo '# Ubuntu 18.04 test image built ################################'
		docker image build --file Dockerfile-test \
				--build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" \
				--build-arg BASE_IMAGE=sotirisp/supereight-ci:ros-melodic \
				--tag sotirisp/supereight-ci:18.04-test .
		echo '# ROS Melodic test image built #################################'
		docker rmi -f $(docker images -q --filter label=stage=intermediate)
		;;

	'run-test')
		docker run --tty --interactive --rm sotirisp/supereight-ci:latest-test
		;;

	'push-ci')
		docker push sotirisp/supereight-ci:latest
		docker push sotirisp/supereight-ci:20.04
		docker push sotirisp/supereight-ci:18.04
		docker push sotirisp/supereight-ci:ros-melodic
		;;

	*)
		usage
		exit 1
		;;
esac

