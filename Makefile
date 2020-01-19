.PHONY: all build docker clean run

# 'build' is used inside the build container
build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -buildmode=exe -mod=vendor ./...

docker:
	docker build -t hello_world .

clean:
	-rm -f hello_world
	-docker stop hello_world
	-docker container rm hello_world
	-docker image rm hello_world

run: clean docker
	docker run --rm --name hello_world -p 80:80 hello_world
