# Sử dụng image Eclipse Temurin OpenJDK 17 gọn nhẹ trên Alpine Linux
FROM eclipse-temurin:17-jre-alpine

# Thiết lập thư mục làm việc bên trong container
WORKDIR /app

# Sao chép tệp Fat JAR đã được đóng gói từ bước Gradle bootJar
COPY build/libs/*.jar app.jar

# Mở cổng 8080 cho ứng dụng Spring Boot
EXPOSE 8080

# Thiết lập điểm khởi chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
