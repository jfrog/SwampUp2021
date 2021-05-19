FROM swampup301.jfrog.io/urs-docker/python:3.9.5-slim-buster

WORKDIR  /var/opt/webapp

RUN mkdir -p /var/opt/webapp
ADD webapp_python.tar.gz . 
RUN pip install -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["python3", "main.py"]