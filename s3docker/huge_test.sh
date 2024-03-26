#!/bin/bash -ex
baseDir="$(dirname $0)"
cd "$baseDir"
docker login -u artipie -p artipie localhost:8080/my-docker-s3
time docker pull chgena/qt6buildtest
docker tag chgena/qt6buildtest localhost:8080/my-docker-s3/my-qt6buildtest
time docker push localhost:8080/my-docker-s3/my-qt6buildtest

docker rmi chgena/qt6buildtest:latest
docker rmi localhost:8080/my-docker-s3/my-qt6buildtest
time docker pull localhost:8080/my-docker-s3/my-qt6buildtest
docker rmi localhost:8080/my-docker-s3/my-qt6buildtest
