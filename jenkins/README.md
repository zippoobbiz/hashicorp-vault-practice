This is already included in the docker compose, however, if run this container alone, use the following command.
```bash
docker build -t jenkins-test .
docker run --rm -v `pwd`/jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --network=hashicorp-vault-practice_default jenkins-test
```

