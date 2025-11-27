FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY ./target/saberpro-0.0.1-SNAPSHOT.jar app.jar

# Render expone el puerto que tú declares en el servicio,
# pero la app debe escuchar el puerto de la variable PORT.
ENV PORT=10000
EXPOSE 10000

ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=${PORT}"]
