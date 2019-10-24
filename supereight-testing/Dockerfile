FROM ubuntu:18.04

RUN apt-get update && apt-get -y install build-essential git cmake libeigen3-dev
WORKDIR /usr/local/src/
RUN git clone --depth=1 https://github.com/strasdat/Sophus.git && mkdir -p "Sophus/build" && cd "Sophus/build" && cmake -DCMAKE_BUILD_TYPE=Release .. && make install
WORKDIR /usr/local/src/

