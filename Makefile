.DEFAULT_GOAL := all
tag ?= localhost/stacker_blueprints:latest

docker_run := docker run -it --rm -v $(pwd):/usr/local/src/stacker_blueprints $(tag)

.PHONY: all
all: lint test

lint: .build stacker_blueprints
	@$(docker_run) flake8 stacker_blueprints

.PHONY: build
build: .build

.build: Dockerfile setup.py setup.cfg
	docker build --tag $(tag) .
	@touch .build

test: .build stacker_blueprints tests
	@$(docker_run) python setup.py test

.PHONY: shell
shell: .build
	@$(docker_run) bash
