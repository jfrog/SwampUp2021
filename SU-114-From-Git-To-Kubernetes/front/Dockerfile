ARG SERVER_NAME
FROM $SERVER_NAME-docker.jfrog.io/node:14-alpine3.10

WORKDIR /tmp/

ENV URL="morty.com"
COPY package app/
RUN ls app/
COPY updateAndRun.sh .
RUN chmod u+x updateAndRun.sh
RUN ls
RUN npm i -g serve

EXPOSE 80

ENTRYPOINT ["/bin/sh", "-c", "./updateAndRun.sh $URL"]
