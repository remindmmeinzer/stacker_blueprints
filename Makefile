.PHONY: all lint test

all: lint test

lint:
	flake8 stacker_blueprints

test:
	python setup.py test
