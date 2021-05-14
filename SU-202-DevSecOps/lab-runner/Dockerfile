FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine AS PACKAGER

ENV GRADLE_VERSION="7.0"
ENV PATH="/usr/local:/usr/local/gradle-$GRADLE_VERSION/bin:$PATH"

WORKDIR /usr/local

# install curl and jq
RUN apk add --update \
    curl jq docker \
    && rm -rf /var/cache/apk/*

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    rm -f gradle-${GRADLE_VERSION}-bin.zip

# install jfrog CLI
RUN curl -fL https://getcli.jfrog.io | sh

# add sources
ADD build.gradle .
ADD settings.gradle .
ADD src src
ADD docker/Dockerfile .

# add scripts
ADD lab-runner/template-create-repo.json .
ADD lab-runner/entrypoint.sh .
ADD scripts scripts

# set permissions
RUN chmod +x entrypoint.sh

CMD entrypoint.sh