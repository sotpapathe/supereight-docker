<!-- SPDX-FileCopyrightText: 2019-2023 Sotiris Papatheodorou -->
<!-- SPDX-License-Identifier: CC0-1.0 -->

# supereight-docker

Docker images for
[supereight](https://bitbucket.org/smartroboticslab/supereight-public/src/master/)
and [supereight 2](https://bitbucket.org/smartroboticslab/supereight2/).

Depending on how your system is set up, you might have to run the following
commands as root (using `sudo`). You will also have to start the docker daemon
by running `docker` (also possibly as root).



## supereight-ci

Docker image for running CI pipelines for supereight. It contains all the
dependencies required to compile supereight (without a GUI) and its unit tests.
Generated from [Dockerfile](./Dockerfile) and available on
[DockerHub](https://hub.docker.com/repository/docker/sotirisp/supereight-ci).

In order for CMake to find googletest and successfully compile the tests, the
following environment variable has been already set in the image:

``` sh
GTEST_ROOT=/usr/local/src/googletest/googletest/
``` 

### Building the images

``` sh
# Build all images
make
# Build only the image based on Ubuntu 18.04
make 18.04
```

### Pushing the built images to DockerHub

``` sh
make push
```

### Running a temporary container using an image

``` sh
# Run using the default image (the value of IMAGE in Makefile)
make run
# Run using the image tagged "sotirisp/supereight-ci:18.04"
make IMAGE=18.04 run
```



## supereight-test

Docker image for testing the private SRL version of supereight. It contains all
required dependencies to compile supereight without a GUI and its unit tests.
Unlike supereight-ci, it also contains a clone of the supereight-srl
repository. Generated from [Dockerfile](./Dockerfile-test).

### SSH key setup

Before building the image you'll need to create a passwordless SSH key and
authorize it to read the private supereight repository. The key must be placed
in the file `~/.ssh/git_readonly_key`.

### Building the image

After setting up the SSH key run

``` sh
# Build using the default image (the value of IMAGE in Makefile)
make test
# Build using the image tagged "sotirisp/supereight-ci:18.04"
make IMAGE=18.04 run
```

### Running a temporary container using the image

``` sh
# Run using the default image (the value of IMAGE in Makefile)
make run-test
# Run using the image tagged "sotirisp/supereight-ci:18.04"
make IMAGE=18.04 run-test
```

Note that if you exit the container, any changes you've made will be discarded.



## Cleaning images

To remove any leftover images and containers run

``` sh
make clean
```

**CAUTION**: This will affect all docker images/containers, not just the
supereight ones.
