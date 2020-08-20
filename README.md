<!-- SPDX-FileCopyrightText: 20192020 Sotiris Papatheodorou -->
<!-- SPDX-License-Identifier: CC0-1.0 -->

# supereight-docker

Docker images for [supereight](https://github.com/emanuelev/supereight).



## supereight-ci

Docker image for running CI pipelines for
[supereight](https://github.com/emanuelev/supereight). It contains all
required dependencies to compile supereight without a GUI and its unit tests.

In order for CMake to find googletest and successfully compile the tests, the
following environment variable has been already set in the image:
``` bash
GTEST_ROOT=/usr/local/src/googletest/googletest/
```

### Building the image

``` bash
make
```

### Pushing the built image to DockerHub

``` bash
make push-ci
```

### Running a temporary container using the image

``` bash
make run-ci
```


