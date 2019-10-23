FROM jenkinsci/blueocean

ARG HOST_DOCKER_GID

USER root
RUN apk update
RUN apk add py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
RUN pip install docker-compose

#RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#RUN chmod +x /usr/local/bin/docker-compose
#RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN addgroup -g "$HOST_DOCKER_GID" dockerbis
RUN addgroup jenkins docker
RUN addgroup jenkins dockerbis

USER jenkins
