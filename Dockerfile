# Image installs with latest Java 8 OpenJDK on Alpine Linux
FROM openjdk:8-jdk-alpine

ENV JENKINS_SWARM_VERSION 3.6
ENV HOME /home/jenkins-slave

# Update and upgrade apk then install required packages
RUN apk update && \
	apk upgrade && \
	apk --no-cache add bash && \
	apk --no-cache add curl && \
	apk --no-cache add maven && \
	apk --no-cache add git && \
	apk --no-cache add subversion && \
	apk --no-cache add docker

RUN adduser -h $HOME -D jenkins-slave

# Download the latest Jenkins swarm client with curl - version 3.6
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
