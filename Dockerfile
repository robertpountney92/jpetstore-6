FROM ubuntu:16.04

# Install java
RUN apt-get update -y && \
    apt-get install wget default-jdk -y

# Create Tomcat user    
RUN useradd -r tomcat9 --shell /bin/false

# Install tomcat
RUN cd /opt && \
    wget http://mirror.reverse.net/pub/apache/tomcat/tomcat-9/v9.0.22/bin/apache-tomcat-9.0.22.tar.gz && \
    tar -zxf apache-tomcat-9.0.22.tar.gz && \
    ln -s apache-tomcat-9.0.22 tomcat && \
    chown -hR tomcat9: tomcat apache-tomcat-9.0.22

# WORKDIR /opt/tomcat/webapps

# Deploy app
# RUN rm -r /opt/tomcat/webapps/ROOT && \
#     wget https://broyal.blob.core.windows.net/mta/spring-petclinic.war && \
#     cp spring-petclinic.war /opt/tomcat/webapps/ROOT.war

EXPOSE 8080
WORKDIR /home/app

# COPY src /home/app/src
# COPY mvnw /home/app
# COPY pom.xml /home/app
COPY . /home/app/

RUN /home/app/mvnw clean package

CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]

