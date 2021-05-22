FROM swampup301.jfrog.io/urs-docker/python:3.9.5-slim-buster
LABEL maintainer="yannc@jfrog.com"

RUN apt-get update && apt-get install -y curl git

RUN curl -fL https://getcli.jfrog.io | sh &&  chmod 755 jfrog &&  mv jfrog /usr/local/bin/

CMD ["/bin/bash", "-c", "jfrog --version"]