FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /code
COPY . .
ENV MAVEN_OPTS="-Xmx512m"
RUN ./mvnw package

FROM openjdk:8-jre-alpine
COPY --from=build /code/target/*.jar /code/app.jar
WORKDIR /code
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
