#!/bin/bash -ex
baseDir="$(dirname $0)"
cd "$baseDir"
docker login -u artipie -p artipie localhost:8080/my-docker-s3
docker pull --platform linux/arm64 ubuntu:20.04 # Not used on my amd64 system
docker tag ubuntu:20.04 localhost:8080/my-docker-s3/my-ubuntu
docker push localhost:8080/my-docker-s3/my-ubuntu

docker rmi ubuntu:20.04
docker rmi localhost:8080/my-docker-s3/my-ubuntu
docker pull localhost:8080/my-docker-s3/my-ubuntu
docker rmi localhost:8080/my-docker-s3/my-ubuntu
