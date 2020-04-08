FROM ubuntu:18.04

# Install required packages ###################################################
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get -y install \
		build-essential \
		git \
		cmake \
		libeigen3-dev \
		libopencv-dev \
	&& rm -rf /var/lib/apt/lists/*



# Install dependencies from source ############################################

# Sophus
WORKDIR /usr/local/src/
RUN git clone https://github.com/strasdat/Sophus.git
RUN mkdir -p /usr/local/src/Sophus/build
WORKDIR /usr/local/src/Sophus/build
RUN git checkout v1.0.0
RUN sed -i \
		's/option(BUILD_TESTS "Build tests." ON)/option(BUILD_TESTS "Build tests." OFF)/' \
		/usr/local/src/Sophus/CMakeLists.txt
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

