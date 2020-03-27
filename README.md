# supereight-docker
Docker images for [supereight](https://github.com/emanuelev/supereight).



## Building an image
```
docker image build --tag supereight-testing ./supereight-testing/
```



## Running a temporary container using an image
```
docker run --tty --interactive --rm supereight-testing
```



## Pushing the built image to DockerHub
```
docker push sotirisp/supereight-testing:latest
```

