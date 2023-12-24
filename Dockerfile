FROM nginx:latest AS build
WORKDIR /code
COPY . .
ENV JAVA_HOME=/usr/lib/jvm/
RUN ./mvnw package

FROM openjdk:8-jre-alpine
COPY --from=build /code/target/*.jar /code/app.jar
WORKDIR /code
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
