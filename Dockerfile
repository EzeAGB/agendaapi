# Usa una imagen base de OpenJDK
FROM openjdk:25-jdk-slim

# Crea un volumen para la aplicación
VOLUME /tmp

# Copia el archivo JAR de tu aplicación al contenedor
# Asegúrate de que el nombre del archivo JAR coincida con el tuyo
COPY target/agenda-0.0.1-SNAPSHOT.jar app.jar

# Define la variable de entorno que Spring Boot usará para acceder al JAR
ENV SPRING_PROFILES_ACTIVE=prod

# Expone el puerto de la aplicación (8080 es el predeterminado para Spring Boot)
EXPOSE 9999

# Comando para ejecutar la aplicación
ENTRYPOINT ["java","-jar","/app.jar"]