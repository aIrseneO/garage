## CLI
```bash
printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-user}" | base64 --decode);echo
printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

docker pull openjdk

docker run --rm --network host -v $PWD/local:/jenkins openjdk java -jar /jenkins/jenkins-cli.jar -s http://192.168.1.112:30070/ -auth admin:<API token>

alais jc='docker run --rm --network host -v $PWD/local:/jenkins openjdk java -jar /jenkins/jenkins-cli.jar -s http://192.168.1.112:30070/ -auth admin:<API token> -webSocket'

docker run --rm --network host -v $PWD/local:/jenkins openjdk java -jar /jenkins/jenkins-cli.jar -s http://192.168.1.112:30070/ -auth admin:<API token> -webSocket list-jobs
```