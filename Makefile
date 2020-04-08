# SPDX-FileCopyrightText: 2019-2020 Sotiris Papatheodorou
# SPDX-License-Identifier: CC0-1.0

all: build-ci

build-ci:
	docker image build --file Dockerfile-CI --tag supereight-ci:latest .

push-ci:
	docker push sotirisp/supereight-ci:latest

run-ci:
	docker run --tty --interactive --rm supereight-ci:latest

