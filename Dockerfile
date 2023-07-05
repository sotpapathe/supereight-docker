# SPDX-FileCopyrightText: 2019-2023 Smart Robotics Lab, Imperial College London, Technical University of Munich
# SPDX-FileCopyrightText: 2019-2023 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

ARG BASE_IMAGE=ubuntu:22.04
FROM "$BASE_IMAGE" as supereight-ci

# Set the directory the shell is in after starting the container
WORKDIR /usr/local/src/

# Install the base packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
		clang \
		cmake \
		g++ \
		git \
		libgomp1 \
		libomp-dev \
		libtbb-dev \
		make \
		openssh-client \
		python3 \
		python3-pip \
		time \
	&& rm -rf /var/lib/apt/lists/*

# Install googletest from source
RUN git clone https://github.com/google/googletest.git /usr/local/src/googletest \
	&& cd /usr/local/src/googletest/googletest \
	&& git checkout release-1.8.1 \
	&& cmake -DCMAKE_BUILD_TYPE=Release . \
	&& make -j \
	&& rm -rf /usr/local/src/googletest/.git
ENV GTest_ROOT=/usr/local/src/googletest/googletest/

# Install the supereight and supereight-testbot dependencies
RUN apt-get update && apt-get -y install \
		clang-format \
		clang-tools \
		doxygen \
		libboost-dev \
		libeigen3-dev \
		liboctomap-dev \
		libopencv-dev \
		libpcl-dev \
		libyaml-cpp-dev \
		valgrind \
	&& rm -rf /var/lib/apt/lists/*
RUN pip3 install reuse==0.13.0
