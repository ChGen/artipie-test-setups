## artipie-docker + s3 storage bench

### Server
```
docker compose up
...
docker-compose rm -fv
```

### Client

Run test scripts, from simple to hard:
```
./ub_fs_test.sh
./ub_test.sh
./huge_test.sh
```
