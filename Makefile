.PHONY: build
build:
	docker build -f Dockerfile --rm -t academy_content .

.PHONY: up
up:
	docker-compose up -d
