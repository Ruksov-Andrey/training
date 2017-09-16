FROM tomcat:8.0
ARG NEXUS=http://172.20.20.12:8081/nexus/content/repositories/training/task4/
ARG WEBAPPS=/usr/local/tomcat/webapps
ARG VERSION=1.0.1
RUN wget -P ${WEBAPPS} ${NEXUS}${VERSION}/task4.war