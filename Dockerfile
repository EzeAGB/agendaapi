# Etapa 1: Construir la aplicación
# Usamos una imagen de Maven que incluye OpenJDK 21
FROM maven:3-openjdk-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Crear la imagen final de despliegue
# Usamos una imagen ligera de OpenJDK 21 para el despliegue
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/agenda-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]