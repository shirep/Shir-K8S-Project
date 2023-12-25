FROM ubuntu:latest AS build
WORKDIR /code
COPY . .
RUN ls
RUN ./mvnw package
RUN ls

FROM openjdk:8-jre-alpine
WORKDIR /code
RUN ls
COPY --from=build /code/target/*.jar /code/
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
