FROM jenkins/jenkins:2.319.3-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
	signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
	https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.2 docker-workflow:1.28 \
kubernetes:latest configuration-as-code:latest credentials:latest \
git:latest git-client:latest github:latest github-oauth:latest slack:latest \
github-oauth:latest"
#	pipeline-model-definition:latest thinBackup:latest \
#	workflow-aggregator:latest ssh-slaves:latest ssh-agent:latest \
#	jdk-tool:latest command-launcher:latest  \
#	google-compute-engine:latest pegdown-formatter:latest"

# Reference
#	https://www.jenkins.io/doc/book/installing/docker/
