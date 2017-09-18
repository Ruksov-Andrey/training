FROM tomcat:8.0-jre8
ARG NEXUS=http://172.20.20.12:8081/nexus/service/local/repositories/snapshots/content/task4/
ARG WEBAPPS=/usr/local/tomcat/webapps
ARG VERSION=1.0.10
RUN wget -P ${WEBAPPS} ${NEXUS}${VERSION}/task4.war

