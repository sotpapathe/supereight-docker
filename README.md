<!-- SPDX-FileCopyrightText: 20192020 Sotiris Papatheodorou -->
<!-- SPDX-License-Identifier: CC0-1.0 -->

# supereight-docker

Docker images for
[supereight](https://bitbucket.org/smartroboticslab/supereight-public/src/master/).

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

#### Building the image

``` sh
./build.sh ci
```

#### Pushing the built image to DockerHub

``` sh
./build.sh push-ci
```

#### Running a temporary container using the image

``` sh
./build.sh run-ci       # Uses the image tagged 'latest'
./build.sh run-ci 18.04 # Uses the image tagged '18.04'
```



## supereight-test

Docker image for testing the private SRL version of supereight. It contains all
required dependencies to compile supereight without a GUI and its unit tests.
Unlike supereight-ci, it also contains a clone of the supereight-srl
repository. Generated from [Dockerfile](./Dockerfile-test).

#### SSH key setup

Before building the image you'll need to create a passwordless SSH key and
authorize it to read the private supereight repository. The key must be placed
in the file `~/.ssh/git_readonly_key`.

#### Building the image

After setting up the SSH key run

``` sh
./build.sh test
```

#### Running a temporary container using the image

``` sh
./build.sh run-test       # Uses the image tagged 'latest'
./build.sh run-test 18.04 # Uses the image tagged '18.04'
```

Note that if you exit the container, any changes you've made will be discarded.



## Repository management

#### Cleaning images

To remove any leftover images and containers run

``` sh
./build.sh clean
```

**CAUTION**: This will affect all docker images/containers, not just the
supereight ones.
