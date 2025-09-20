
# Etapa 1: Construcción
# Usa una imagen de Amazon Corretto con JDK 21
FROM amazoncorretto:25-alpine3.21-jdk AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Despliegue
# Usa una imagen ligera de Amazon Corretto con JRE 21
FROM amazoncorretto:21-jre-slim-al2
WORKDIR /app
COPY --from=build /app/target/agenda-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java","-jar","/app.jar"]