#!/bin/bash -ex
baseDir="$(dirname $0)"
cd "$baseDir"
docker-compose down
rm -rf ./minio-data ./data || sudo rm -rf ./minio-data ./data
docker-compose rm -fv
mkdir -p ./data
docker-compose up -d

