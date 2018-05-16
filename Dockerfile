FROM centos:7

MAINTAINER Jens Reimann <jreimann@redhat.com>
LABEL maintainer "Jens Reimann <jreimann@redhat.com>"

RUN yum install -y git wget java-devel which rsync

RUN \
	wget http://www-eu.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz && \
	tar xzf apache-maven-3.5.3-bin.tar.gz && \
	rm apache-maven-3.5.3-bin.tar.gz

ENV MAVEN_HOME=/apache-maven-3.5.3

COPY root /

RUN mkdir /output
VOLUME /output

ENTRYPOINT ["/build-kura"]
