```
cd ~/w/artipie/support/artipie/artipie-main/src/test/resources/debian

mc rm -r --force s3test/repo-test
curl http://localhost:8080/my-deb-s3/main/aglfn.deb --upload-file aglfn_1.7-3_amd64.deb

mc ls -r s3test/repo-test
curl -f -kv http://localhost:9000/repo-test/

curl -f -v http://localhost:8080/my-deb-s3/main/aglfn.deb -o aglfn-out.deb
cmp out.deb aglfn_1.7-3_amd64.deb

mc rm -r --force s3test/repo-test
curl http://localhost:8080/my-deb-s3/main/pspp.deb --upload-file pspp_1.2.0-3_amd64.deb
curl -f -v http://localhost:8080/my-deb-s3/main/pspp.deb -o pspp-out.deb

mc rm -r --force s3test/repo-test
curl -i  -X PUT  --data-binary @pspp_1.2.0-3_amd64.deb http://localhost:8080/my-deb-s3/main/pspp.deb
curl -f -v http://localhost:8080/my-deb-s3/main/pspp.deb -o pspp-out.deb
cmp pspp* ; echo $?

mc rm -r --force s3test/repo-test
curl -i  -X PUT  --data-binary @libobus-ocaml_1.2.3-1+b3_amd64.deb http://localhost:8080/my-deb-s3/main/libobus-ocaml.deb
curl -f -v http://localhost:8080/my-deb-s3/main/libobus-ocaml.deb -o libobus-ocaml-out.deb
cmp libobus-ocaml* ; echo $?

mc rm -r --force s3test/repo-test

curl -i  -X PUT  --data-binary @~/jdk-21_linux-x64_bin.deb http://localhost:8080/my-deb-s3/main/jdk.deb
curl http://localhost:8080/my-deb-s3/main/jdk.deb --upload-file ~/jdk-21_linux-x64_bin.deb

curl -f -v http://localhost:8080/my-deb-s3/main/jdk.deb -o ~/jdk-out.deb
cmp pspp* ; echo $?
```



```
mc alias set s3test http://localhost:9000 minio123 minio123
mc mb s3test/repo-test --region us-east-1
mc anonymous set public s3test/repo-test
mc ls -r s3test/repo-test
curl -f -kv http://localhost:9000/repo-test/
```




@Tzahif , I've done local manual test with Artipie + minIO S3, using your `docker-compose.yaml` and configs above. I used `artipie/artipie-ubuntu:1.0-SNAPSHOT` built locally.
The only extra step required was bucket configuration:
```
mc alias set s3test http://localhost:9000 minio123 minio123
mc mb s3test/repo-test --region us-east-1
mc anonymous set public s3test/repo-test
# list:
mc ls -r s3test/repo-test
curl -f -kv http://localhost:9000/repo-test/
```

I used 3 deb files (see log) and also checked that those could be downloaded again and match originals.

```
ls -lah *.deb
-rw-r--r-- 1 evgeny evgeny  30K Nov 24 17:07 aglfn_1.7-3_amd64.deb
-rw-r--r-- 1 evgeny evgeny 1.3M Feb 14 10:06 libobus-ocaml_1.2.3-1+b3_amd64.deb
-rw-r--r-- 1 evgeny evgeny 3.7M Feb 14 09:55 pspp_1.2.0-3_amd64.deb

curl http://localhost:8080/my-deb-s3/main/aglfn.deb --upload-file aglfn_1.7-3_amd64.deb
curl -f -v http://localhost:8080/my-deb-s3/main/aglfn.deb -o aglfn-out.deb
cmp out.deb aglfn_1.7-3_amd64.deb

curl -i  -X PUT  --data-binary @pspp_1.2.0-3_amd64.deb http://localhost:8080/my-deb-s3/main/pspp.deb
curl -f -v http://localhost:8080/my-deb-s3/main/pspp.deb -o pspp-out.deb
cmp pspp* ; echo $?
0

curl -i  -X PUT  --data-binary @libobus-ocaml_1.2.3-1+b3_amd64.deb http://localhost:8080/my-deb-s3/main/libobus-ocaml.deb
curl -f -v http://localhost:8080/my-deb-s3/main/libobus-ocaml.deb -o libobus-ocaml-out.deb
cmp libobus-ocaml* ; echo $?
0

mc ls -r s3test/repo-test
[2024-02-14 10:10:03 MSK]   309B STANDARD my-deb-s3/dists/my-deb-s3/InRelease
[2024-02-14 10:10:03 MSK]   309B STANDARD my-deb-s3/dists/my-deb-s3/Release
[2024-02-14 10:10:03 MSK] 1.7KiB STANDARD my-deb-s3/dists/my-deb-s3/main/binary-amd64/Packages.gz
[2024-02-14 10:07:48 MSK]  29KiB STANDARD my-deb-s3/main/aglfn.deb
[2024-02-14 10:10:02 MSK] 1.3MiB STANDARD my-deb-s3/main/libobus-ocaml.deb
[2024-02-14 10:08:10 MSK] 3.6MiB STANDARD my-deb-s3/main/pspp.deb

curl -f -v http://localhost:8080/my-deb-s3/dists/my-deb-s3/main/binary-amd64/Packages.gz -o Packages-out.gz
cat Packages-out.gz |gzip -d|grep Package
Package: aglfn
Package: pspp
Package: libobus-ocaml

```

So, I was able to upload & download files without issues.

