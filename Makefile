TOP_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: build
build:
	@cd ${TOP_DIR} && \
	mkdir -p ${TOP_DIR}/build ${TOP_DIR}/output && \
	docker build --build-arg=USER_UID=$(shell id -u) --build-arg=USER_GID=$(shell id -g) --build-arg=USER_NAME=${USER} --tag dart-sdk-on-fedora:local . && \
	docker run --rm -ti -v ${TOP_DIR}/build:/build -v ${TOP_DIR}/output:/output dart-sdk-on-fedora:local
