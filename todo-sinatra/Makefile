all: test

docker-build:
	docker-compose build todo

start:
	docker-compose up todo

test:
	docker-compose run todo rspec
start-prod: build
	docker-compose up dashboard
