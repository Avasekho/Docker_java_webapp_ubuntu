FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install default-jdk wget maven git -y

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz -O /tmp/tomcat.tar.gz && \
    cd /tmp && tar xvfz tomcat.tar.gz && \
    cp -Rv /tmp/apache-tomcat-9.0.63/* /usr/local/tomcat/ 

#Add a user ubuntu with UID 1001
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu && \
   chown -R ubuntu:root /usr/local/tomcat && \
   chgrp -R 0 /usr/local/tomcat && \
   chmod -R g=u /usr/local/tomcat

#Specify the user with UID
USER 1001

WORKDIR /tmp/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /tmp/boxfuse-sample-java-war-hello/
RUN mvn package
WORKDIR /tmp/boxfuse-sample-java-war-hello/target/
COPY hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]