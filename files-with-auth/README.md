## How to use

Testing Artipie (binary) files adapter with basic auth configured.

### Testing this configuration

1. Run Artipie server: `./runDocker.sh`
2. Generate token with the command below and copy token value from the output. Alternatively, go to Swagger documentation page http://localhost:8086/api/index.html, choose "Auth token" in "Select a definition" and get token value from there.
```
curl -vX 'POST' 'http://localhost:8086/api/v1/oauth/token' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{
  "name": "artipie",
  "pass": "qwerty"
}'
```
3. Get repositories list (put your own token value):
```
curl -vX 'GET'   'http://localhost:8086/api/v1/repository/list'   -H 'accept: application/json'   -H 'Authorization: Bearer TOKEN_VALUE'
```
3. Without auth, anonymous PUT operation must fail:
```
curl -vX PUT -d 'Hello world!' http://localhost:8085/my-files/test.txt
```
4. With correct credentials operation must succeed:
```
curl -vX PUT -d 'Hello world!' -u 'artipie:qwerty' http://localhost:8085/my-files/test.txt
```
5. Both, anonymous and logged in could read this repo:
```
curl -vX GET http://localhost:8085/my-files/test.txt
curl -vX GET -u 'artipie:qwerty' http://localhost:8085/my-files/test.txt
```
