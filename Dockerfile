FROM adoptopenjdk/openjdk11
CMD ["./gradlew", "build"]
ARG JAR_FILE_PATH=build/libs/*SNAPSHOT.jar
COPY ${JAR_FILE_PATH} app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
