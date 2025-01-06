FROM ubuntu:latest as build
RUN apt-get update
RUN apt-get install openjdk-23 -y
COPY . .
RUN ./gradlew bootJar --no-daemon