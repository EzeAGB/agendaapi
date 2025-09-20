## Build

FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /workspace

COPY pom.xml .
COPY .mvn .mvn
COPY mvnw mvnw

RUN ./mvnw -q -B -DskipTests dependency:go-offline || true

COPY src src
RUN ./mvnw -q -B -DskipTests clean package

## Runtime

FROM eclipse-temurin:17-jre

ENV APP_HOME=/app \
    PORT=8080 \
    SPRING_PROFILES_ACTIVE=prod

WORKDIR ${APP_HOME}

RUN useradd --system --create-home --home-dir ${APP_HOME} spring
USER spring

COPY --from=build /workspace/target/agenda-0.0.1-SNAPSHOT.jar ${APP_HOME}/agenda-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/agenda-0.0.1-SNAPSHOT.jar"]