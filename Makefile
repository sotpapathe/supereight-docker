# SPDX-FileCopyrightText: 2019-2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

all: build-ci

build-ci:
	docker image build --file Dockerfile-CI --tag supereight-ci:18.04 .

push-ci:
	docker push sotirisp/supereight-ci:18.04

run-ci:
	docker run --tty --interactive --rm supereight-ci:18.04

