# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine

# Add a volume pointing to /tmp
VOLUME /tmp
# Make port 8080 available to the world outside this container
EXPOSE 8080

ADD /opt/glowroot/glowroot.jar glowroot.jar
COPY /opt/glowroot/lib/glowroot-embedded-collector.jar  lib/glowroot-embedded-collector.jar
COPY /opt/glowroot/lib/glowroot-central-collector-https-linux.jar  lib/glowroot-central-collector-https-linux.jar
COPY /opt/glowroot/lib/glowroot-central-collector-https-osx.jar  lib/glowroot-central-collector-https-osx.jar
COPY /opt/glowroot/lib/glowroot-central-collector-https-windows.jar  lib/glowroot-central-collector-https-windows.jar
COPY /opt/glowroot/glowroot.properties glowroot.properties
 


#COPY /opt/glowroot/ /opt/glowroot/ 


# The application's jar file
ARG JAR_FILE=target/websocket-demo-0.0.1-SNAPSHOT.jar
ARG OK=/opt/glowroot/glowroot.jar
# Add the application's jar to the container
ADD ${JAR_FILE} websocket-demo.jar
#ADD ${OK} glowroot.jar
# Run the jar file 

CMD ["java", "-javaagent:/glowroot.jar","-Dglowroot.agent.id=Docker","-jar", "/websocket-demo.jar"]

