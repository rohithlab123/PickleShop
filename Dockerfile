# Stage 1: Build the application using Maven and Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the source code and pom.xml into the container
COPY pom.xml .
COPY src ./src

# Run maven to compile code and build the fresh ROOT.war file
RUN mvn clean package -DskipTests

# Stage 2: Deploy the compiled WAR file into Tomcat 9
FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat

RUN rm -rf webapps/*
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

# 1. Change Tomcat's default HTTP port configuration from 8080 to match Render's port
RUN sed -i 's/port="8080"/port="${port.http}"/g' conf/server.xml

# 2. DISABLE THE SHUTDOWN PORT completely (Set it to -1) so Render's checks don't hit it
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/g' conf/server.xml

# Set default fallback port property
ENV JAVA_OPTS="-Dport.http=10000"

EXPOSE 10000
CMD ["catalina.sh", "run"]
