FROM ubuntu:latest AS build
WORKDIR /code
RUN apt-get update && apt-get install -y openjdk-17-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
COPY . .
RUN ./mvnw -e -X package

FROM openjdk:8-jre-alpine
WORKDIR /code
COPY --from=build /code/target/*.jar /code/
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
