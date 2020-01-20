FROM ubuntu:18.04



# Install required packages ###################################################
RUN apt-get update && apt-get -y install build-essential git cmake libeigen3-dev



# Install dependencies from source ############################################

# Install Sophus
WORKDIR /usr/local/src/
RUN git clone https://github.com/strasdat/Sophus.git \
		&& mkdir -p "Sophus/build" \
		&& cd "Sophus/build" \
		&& git checkout v1.0.0 \
		&& cmake -DCMAKE_BUILD_TYPE=Release .. \
		&& make install

# Install googletest
WORKDIR /usr/local/src/
RUN git clone --depth=1 https://github.com/google/googletest.git && cd "googletest/googletest" && cmake -DCMAKE_BUILD_TYPE=Release . && make



WORKDIR /usr/local/src/

