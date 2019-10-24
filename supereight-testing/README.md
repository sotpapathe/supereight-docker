# supereight-testing
Docker image for running the
[supereight](https://github.com/emanuelev/supereight) tests. It contains all
required dependencies to compile supereight without a GUI and its tests.

To run the tests the following environment variable must be set:
```
GTEST_ROOT=/usr/local/src/googletest/googletest/
```

