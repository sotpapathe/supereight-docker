# SPDX-FileCopyrightText: 2019-2023 Smart Robotics Lab, Imperial College London, Technical University of Munich
# SPDX-FileCopyrightText: 2019-2023 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

IMAGE = 20.04
SSH_PRIVATE_KEY = ~/.ssh/supereight_readonly_key

.PHONY: all
all: 18.04 20.04 22.04 noetic

.PHONY: 18.04
18.04:
	docker image build --build-arg BASE_IMAGE=ubuntu:$@ \
		--tag sotirisp/supereight-ci:$@ .

.PHONY: 20.04
20.04:
	docker image build --build-arg BASE_IMAGE=ubuntu:$@ \
		--tag sotirisp/supereight-ci:$@ .

.PHONY: 22.04
22.04:
	docker image build --build-arg BASE_IMAGE=ubuntu:$@ \
		--tag sotirisp/supereight-ci:$@ .

.PHONY: noetic
noetic:
	docker image build --build-arg BASE_IMAGE=ros:$@-ros-base \
		--tag sotirisp/supereight-ci:ros-$@ .

.PHONY: push
push:
	@echo 'Enter the docker hub password and press [Enter] and then [Ctrl+D]'
	docker login --username sotirisp --password-stdin
	docker push sotirisp/supereight-ci:18.04
	docker push sotirisp/supereight-ci:20.04
	docker push sotirisp/supereight-ci:22.04
	docker push sotirisp/supereight-ci:ros-noetic
	docker logout

.PHONY: pull
pull:
	docker pull sotirisp/supereight-ci:18.04
	docker pull sotirisp/supereight-ci:20.04
	docker pull sotirisp/supereight-ci:22.04
	docker pull sotirisp/supereight-ci:ros-noetic

.PHONY: run
run:
	docker run --tty --interactive --rm sotirisp/supereight-ci:$(IMAGE)

.PHONY: test
test:
	cp $(SSH_PRIVATE_KEY) id_rsa
	docker image build --file Dockerfile-test \
		--build-arg BASE_IMAGE=sotirisp/supereight-ci:$(IMAGE) \
		--tag sotirisp/supereight-ci:$(IMAGE)-test  .
	rm -f id_rsa

.PHONY: run-test
run-test:
	docker run --tty --interactive --rm sotirisp/supereight-ci:$(IMAGE)-test

.PHONY: clean
clean:
	@printf '\033[1;31mCAUTION\033[m: This will affect all docker images/containers, not just the supereight ones\n'
	docker rmi -f $(shell docker images -q --filter label=stage=intermediate) 2>/dev/null || true
	docker container prune
	docker image prune
