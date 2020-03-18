FROM ubuntu:16.04
MAINTAINER Daniele De Lorenzi <daniele.delorenzi@fastnetserv.net>

RUN apt update && \
    apt install curl wget openjdk-8-jdk git -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b master https://github.com/streamaserver/streama.git && \
    cd streama && ./gradlew assemble && mkdir -p /data/streama && \
    mv ./build/libs/*.jar /data/streama/streama.jar && \
    chmod u+x /data/streama/streama.jar && \
    cp docs/sample_application.yml .

# test for image scanner
RUN echo "AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" >> /root/credentials
RUN echo "AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" >> /root/credentials
RUN echo "SOME_SECRET_KEY=AKIAIOSFODNN7EXAMPLE" >> /root/credentials
RUN echo "MY_SECRET_KE=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" >> /root/credentials

EXPOSE 8080

#CMD ["./data/streama/streama.war"]
CMD ["java -Dgrails.env=$ACTIVE_PROFILE -jar ./data/streama/streama.jar"]
