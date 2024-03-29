#!/bin/bash -ex
baseDir="$(dirname $0)"
cd "$baseDir"
docker-compose down
rm -rf ./minio-data || sudo rm -rf ./minio-data
docker-compose rm -fv
docker-compose up -d

