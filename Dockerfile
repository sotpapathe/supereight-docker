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
RUN git clone https://github.com/strasdat/Sophus.git /usr/local/src/Sophus \
	&& mkdir -p /usr/local/src/Sophus/build \
	&& cd /usr/local/src/Sophus/build \
	&& git checkout v1.0.0 \
	&& sed -i \
		's/option(BUILD_TESTS "Build tests." ON)/option(BUILD_TESTS "Build tests." OFF)/' \
		/usr/local/src/Sophus/CMakeLists.txt \
	&& cmake -DCMAKE_BUILD_TYPE=Release .. \
	&& make -j install \
	&& rm -rf /usr/local/src/Sophus \
	&& rm -rf /usr/local/src/Sophus/.git

# googletest
RUN git clone https://github.com/google/googletest.git /usr/local/src/googletest \
	&& cd /usr/local/src/googletest/googletest \
	&& git checkout release-1.10.0 \
	&& cmake -DCMAKE_BUILD_TYPE=Release . \
	&& make -j \
	&& rm -rf /usr/local/src/googletest/.git



# Set the directory the shell is in after starting the container ##############
WORKDIR /usr/local/src/

