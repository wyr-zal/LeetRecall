FROM maven:3.9.10-eclipse-temurin-21 AS build
WORKDIR /workspace
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -q -DskipTests package

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
RUN addgroup -S leetrecall && adduser -S leetrecall -G leetrecall
COPY --from=build /workspace/target/leet-recall-server-1.0.0.jar app.jar
USER leetrecall
EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "/app/app.jar"]
