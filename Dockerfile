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

# Remove default Tomcat apps to avoid conflicts
RUN rm -rf webapps/*

# Copy the compiled war file directly from Stage 1 (Build stage)
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
