FROM eclipse-temurin:24-jdk

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY src src

RUN ./gradlew build -x test

EXPOSE 8080

CMD ["java", "-jar", "build/libs/flagd-poc-0.0.1-SNAPSHOT.jar"]
