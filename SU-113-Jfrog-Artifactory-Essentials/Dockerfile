FROM alpine:latest
RUN apk update
RUN apk add --no-cache
RUN apk add vim
RUN apk add git
RUN apk add curl
#RUN apk add docker.io
RUN apk add bash
RUN apk add --no-cache docker-cli

ENV JFROG_CLI_HOME=/opt/jfrog
RUN mkdir /opt/jfrog
RUN curl -fL https://getcli.jfrog.io | sh &&  chmod 755 jfrog &&  mv jfrog /usr/local/bin/
WORKDIR /root