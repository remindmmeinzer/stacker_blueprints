.DEFAULT_GOAL := all
tag ?= localhost/stacker_blueprints:latest

docker_run := docker run -it --rm -v $(shell pwd):/usr/local/src/stacker_blueprints $(tag)

.PHONY: all
all: lint test circle

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
	$(docker_run) bash

# Run the circle jobs locally.
# https://circleci.com/docs/2.0/local-cli/#running-a-job
.PHONY: circle
circle: .circleci/process.yml
	.circleci/circleci local execute -c .circleci/process.yml --job lint
	.circleci/circleci local execute -c .circleci/process.yml --job test-unit

# Run the circleci CLI validator on the config file.
.circleci/.validated: .circleci/config.yml
	@docker run -it --rm \
		-v $(shell pwd):/data \
		circleci/circleci-cli:alpine \
			config validate /data/.circleci/config.yml
	@touch .circleci/.validated

# Convert the friendly config.yml to a ready-to-process process.yml.
# https://circleci.com/docs/2.0/local-cli/#running-a-job
.circleci/process.yml: .circleci/.validated
	@$(eval cid := $(shell docker create \
		-v $(shell pwd):/data \
		--entrypoint /bin/sh \
		circleci/circleci-cli:alpine \
			-c 'circleci config process /data/.circleci/config.yml > /data/.circleci/process.yml'))
	@docker start -ai $(cid)
	@docker cp $(cid):/usr/local/bin/circleci .circleci/circleci
	@docker rm $(cid)
