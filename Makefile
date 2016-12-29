REPO_NAME=concourse-example-custom-resource

all: build

build:
	docker build -t elct9620/$(REPO_NAME) .

run: build
	docker run -it --rm elct9620/$(REPO_NAME) /bin/sh

push: build
	docker push elct9620/concourse-example-custom-resource

sp:
	fly -t lite sp -p custom-resource-example -c concourse.yml -n

up:
	fly -t lite up -p custom-resource-example

dp:
	fly -t lite dp -p custom-resource-example -n

cr:
	fly -t lite cr -r custom-resource-example/monster-db

reset: push dp sp up cr
