FROM swampup301.jfrog.io/urs-docker/groovy:jre16

RUN mkdir -p /home/groovy/webapp/
COPY multi-module-application.jar /home/groovy/webapp/multi-module-application.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/home/groovy/webapp/multi-module-application.jar"]