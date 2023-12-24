FROM maven:3.3-jdk-8 AS build
WORKDIR /code
COPY . .
ENV MAVEN_OPTS="-Xmx8g"
RUN ulimit -n 65536
RUN ./mvnw package

FROM openjdk:8-jre-alpine
COPY --from=build /code/target/*.jar /code/app.jar
WORKDIR /code
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
