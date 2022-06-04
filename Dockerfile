FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN apt update
RUN apt install default-jdk maven tomcat9 git -y
WORKDIR /root
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /root/boxfuse-sample-java-war-hello
RUN mvn package
RUN cp /root/boxfuse-sample-java-war-hello/target/hello-1.0.var /var/lib/tomcat9/webapps/
EXPOSE 80