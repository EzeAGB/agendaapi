# Etapa 1: Construcción
FROM amazoncorretto:21-al2-jdk AS build
WORKDIR /app
RUN yum install -y maven
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Despliegue
# Usamos la misma imagen para garantizar que funcione
FROM amazoncorretto:21-al2-jdk
WORKDIR /app
COPY --from=build /app/target/agenda-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java","-jar","/app.jar"]