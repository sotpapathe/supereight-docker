FROM ubuntu:18.04

# Install required packages ###################################################
RUN apt-get update
RUN apt-get -y install \
		build-essential \
		git \
		cmake \
		libeigen3-dev



# Install dependencies from source ############################################

# Sophus
WORKDIR /usr/local/src/
RUN git clone https://github.com/strasdat/Sophus.git
RUN mkdir -p /usr/local/src/Sophus/build
WORKDIR /usr/local/src/Sophus/build
RUN git checkout v1.0.0
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make install
RUN rm -rf /usr/local/src/Sophus

# googletest
WORKDIR /usr/local/src/
RUN git clone --depth=1 https://github.com/google/googletest.git
WORKDIR /usr/local/src/googletest/googletest
RUN cmake -DCMAKE_BUILD_TYPE=Release .
RUN make



# Set the directory the shell is in after starting the container ##############
WORKDIR /usr/local/src/

