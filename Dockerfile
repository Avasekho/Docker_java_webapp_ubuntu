FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install default-jdk wget maven git tomcat9 -y
ENV CATALINA_BASE /var/lib/tomcat9
ENV CATALINA_HOME /usr/share/tomcat9
WORKDIR /tmp/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /tmp/boxfuse-sample-java-war-hello/
RUN mvn package
WORKDIR /tmp/boxfuse-sample-java-war-hello/target/
RUN cp hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]