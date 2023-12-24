FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /code
COPY . .
ENV MAVEN_OPTS="-Xmx512m"
CMD ["./mvnw", "package"]

FROM openjdk:8-jre-alpine
WORKDIR /code
RUN ls
COPY --from=build /code/target/*.jar /code/
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
