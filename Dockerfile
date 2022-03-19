FROM ubuntu:xenial-20210416
MAINTAINER Daniele De Lorenzi <daniele.delorenzi@fastnetserv.net>

RUN apt update && \
    apt install curl wget openjdk-8-jdk git -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b master https://github.com/streamaserver/streama.git && \
    cd streama && ./gradlew assemble && mkdir -p /data/streama && \
    mv ./build/libs/*.jar /data/streama/streama.jar && \
    chmod u+x /data/streama/streama.jar && \
    cp docs/sample_application.yml .

EXPOSE 8080

CMD ["java -Dgrails.env=$ACTIVE_PROFILE -jar ./data/streama/streama.jar"]
