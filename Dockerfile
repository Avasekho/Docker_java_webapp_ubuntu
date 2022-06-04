FROM tomcat:10.1
RUN apt update
RUN apt install maven git -y
WORKDIR /tmp/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /tmp/boxfuse-sample-java-war-hello/
RUN mvn package
WORKDIR /tmp/boxfuse-sample-java-war-hello/target/
RUN cp hello-1.0.war /var/lib/tomcat10/webapps/
EXPOSE 80 8080
CMD ["catalina.sh", "run"]