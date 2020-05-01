# SPDX-FileCopyrightText: 2019-2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

all: build-ci

build-ci:
	docker image build --file Dockerfile-CI --tag sotirisp/supereight-ci:20.04 --build-arg BASE_IMAGE=ubuntu:20.04 --tag sotirisp/supereight-ci:latest .
	docker image build --file Dockerfile-CI --tag sotirisp/supereight-ci:18.04 --build-arg BASE_IMAGE=ubuntu:18.04 .
	docker image build --file Dockerfile-CI --tag sotirisp/supereight-ci:16.04 --build-arg BASE_IMAGE=ubuntu:16.04 .
	docker image build --file Dockerfile-CI --tag sotirisp/supereight-ci:ros-melodic --build-arg BASE_IMAGE=ros:melodic-ros-base-bionic .

push-ci:
	docker push sotirisp/supereight-ci:latest
	docker push sotirisp/supereight-ci:20.04
	docker push sotirisp/supereight-ci:18.04
	docker push sotirisp/supereight-ci:16.04
	docker push sotirisp/supereight-ci:ros-melodic

run-ci:
	docker run --tty --interactive --rm sotirisp/supereight-ci:latest

