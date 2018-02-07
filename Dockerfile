FROM ubuntu:16.04
MAINTAINER Daniele De Lorenzi <daniele.delorenzi@fastnetserv.net>

RUN apt update && \
    apt install curl wget openjdk-8-jdk build-essential -y
    
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b master https://github.com/dularion/streama.git && \
    cd streama && make && chmod u+x streama.war && \
    cp docs/sample_application.yml .
    
EXPOSE 8080

CMD ["./streama.war"]
