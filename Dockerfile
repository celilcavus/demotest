# 1. Build aşaması
FROM ubuntu:latest AS build

# Paketleri güncelle ve OpenJDK yükle
RUN apt-get update && apt-get install -y openjdk-17-jdk curl unzip

# Çalışma dizinini ayarla
WORKDIR /app

# Proje dosyalarını konteynere kopyala
COPY . .

# Gradle wrapper'ı çalıştırılabilir hale getir
RUN chmod +x ./gradlew

# Gradle build işlemini gerçekleştir
RUN ./gradlew bootJar --no-daemon

# 2. Çalıştırma aşaması
FROM openjdk:17-jdk-slim

# Uygulama için çalışma dizinini belirle
WORKDIR /app/build/libs

# Uygulamanın çalışacağı portu belirt
EXPOSE 8080

# Build aşamasından jar dosyasını kopyala
COPY --from=build /app/build/libs/demotest-0.0.1-SNAPSHOT.jar app.jar

# Uygulamayı başlat
ENTRYPOINT ["java", "-jar", "app.jar"]
