# Etapa 1: Construcción
# Usa la imagen de Amazon Corretto con JDK 25
FROM amazoncorretto:25-alpine3.21-jdk AS build
WORKDIR /app

# Instala Maven dentro de la imagen
RUN apk add --no-cache maven

COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Despliegue
# Usa la imagen ligera de Amazon Corretto con JRE 25
FROM amazoncorretto:25-alpine3.21-jre
WORKDIR /app
COPY --from=build /app/target/agenda-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java","-jar","/app.jar"]