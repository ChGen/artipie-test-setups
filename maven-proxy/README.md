## How to use

```
./runDocker.sh
# ...
curl -kv http://localhost:8085/my-maven/args4j/args4j/2.32/args4j-2.32.pom
ls -lah data/my-maven/args4j/args4j/2.32/

mvn -s ./maven-settings.xml dependency:get -Dartifact=args4j:args4j:2.32:jar
ls -lah data/my-maven/args4j/args4j/2.32/
ls -lah ~/.m2/repository/args4j/args4j/2.32/

```
