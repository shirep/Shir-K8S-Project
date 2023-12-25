FROM ubuntu:latest AS build
WORKDIR /code
RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN ls
COPY . .
RUN ls
RUN ./mvnw -e -X package
RUN ls

FROM openjdk:8-jre-alpine
WORKDIR /code
RUN ls
COPY --from=build /code/target/*.jar /code/
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
