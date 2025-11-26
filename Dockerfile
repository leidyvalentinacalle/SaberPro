FROM eclipse-temurin:17-jdk
COPY "./target/saberpro-0.0.1-SNAPSHOT.jar" "app.jar"
EXPOSE 8094
ENTRYPOINT [ "java", "-jar", "app.jar"]