#!/bin/bash -ex
baseDir="$(dirname $0)"
cd "$baseDir"

docker run -u 0:0 -v $PWD/artipie.yaml:/etc/artipie/artipie.yml -v $PWD/repo:/var/artipie/repo -v $PWD/data:/var/artipie/data -p8080:8080 -p8082:8082 -p8085:8085 -p8086:8086 -it artipie/artipie:v0.30.14
