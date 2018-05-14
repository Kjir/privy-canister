all: build

.PHONY: build
build:
	docker-compose run --rm dev build

docker-build:
	docker-compose build dev

start:
	docker-compose up dev

start-prod: build
	docker-compose up dashboard

test:
	-rm yarn-error.log
	docker-compose run dev test
