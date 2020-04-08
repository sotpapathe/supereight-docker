# supereight-docker
Docker images for [supereight](https://github.com/emanuelev/supereight).



### Building an image
```
docker image build --file Dockerfile-CI --tag supereight-ci:18.04 .
```

### Running a temporary container using an image
```
docker run --tty --interactive --rm supereight-ci
```

### Pushing the built image to DockerHub
```
docker push sotirisp/supereight-ci:18.04
```



## supereight-testing
Docker image for running the
[supereight](https://github.com/emanuelev/supereight) tests. It contains all
required dependencies to compile supereight without a GUI and its tests.

To run the tests the following environment variable must be set:
```
GTEST_ROOT=/usr/local/src/googletest/googletest/
```

