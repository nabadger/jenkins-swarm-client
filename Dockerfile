FROM docker:17.03-rc

ENV JENKINS_SWARM_VERSION 3.6

RUN apk update add && \
    apk upgrade && \
	apk add openjdk8-jre && \
	apk add maven && \
	apk add git && \
	apk add subversion && \ 
    apk add ca-certificates && \
    apk add openssl && \
    update-ca-certificates 

RUN  wget -O swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}.jar

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
