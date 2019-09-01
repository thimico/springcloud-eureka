FROM openjdk:8-jdk-alpine 
FROM maven:alpine as build

# image layer
WORKDIR /app
COPY pom.xml .
COPY src src

RUN mvn clean install -DskipTests

# Image layer: with the application
FROM openjdk:8-jdk-alpine
LABEL "MAINTAINER"="Thiago Menezes <thg.mnzs@gmail.com | thimico@gmail.com>"
VOLUME /tmp
EXPOSE 8080
COPY --from=build /app/target/*.jar /developments/app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/developments/app.jar"]