FROM ubuntu:latest as build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

# Gradle wrapper'ı çalıştırılabilir hale getirin
RUN chmod +x ./gradlew

RUN ./gradlew bootJar --no-daemon

FROM openjdk:23-jdk-slim
EXPOSE 8080
COPY --from=build /build/libs/demotest-0.0.1-SNAPSHOT.jar app.jar


ENTRYPOINT ["java","-jar","app.jar"]
