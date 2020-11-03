<!-- SPDX-FileCopyrightText: 20192020 Sotiris Papatheodorou -->
<!-- SPDX-License-Identifier: CC0-1.0 -->

# supereight-docker

Docker images for [supereight](https://github.com/emanuelev/supereight).

Depending on how your system is set up, you might have to run the following
commands as root (using `sudo`). You will also have to start the docker daemon
by running `docker` (also possibly as root).



## supereight-ci

Docker image for running CI pipelines for
[supereight](https://github.com/emanuelev/supereight). It contains all the
dependencies required to compile supereight (without a GUI) and its unit tests.

#### Building the image

``` bash
./build.sh build-ci
```

#### Pushing the built image to DockerHub

``` bash
./build.sh push-ci
```

#### Running a temporary container using the image

``` bash
./build.sh run-ci
```



## supereight-test

Docker image for testing the private SRL version of supereight. It contains all
required dependencies to compile supereight without a GUI and its unit tests.
Unlike supereight-ci, it also contains a clone of the supereight-srl
repository.

#### Building the image

``` bash
./build.sh build-test
```

Building the test images requires a passwordless SSH private key that is
authorized to read the private repository. The key must be located in
`~/.ssh/git_readonly_key`.

#### Running a temporary container using the image

``` bash
./build.sh run-test
```

Note that if you exit the container, any changes you've made will be discarded.

