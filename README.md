# Báo cáo Thực hành DevOps - Session 11: Bài 5

## Nối Job tự động Build & Push Docker Image sau khi Test Gradle xanh

### 1. Giới thiệu tổng quan
Bài thực hành hoàn thiện chu trình CI/CD hoàn chỉnh bằng cách phân tách quy trình thành 2 Jobs độc lập:
1. **Job `test`:** Chịu trách nhiệm chạy kiểm thử JUnit, biên dịch ứng dụng Spring Boot thành Fat JAR bằng Gradle và đính kèm Artifact `app-jar`.
2. **Job `docker-build`:** Chỉ được phép khởi chạy sau khi Job `test` hoàn thành thành công (sử dụng từ khóa ràng buộc `needs: test`). Job này tải lại Artifact JAR, đóng gói thành Docker Image theo cấu hình `Dockerfile` và đẩy (push) lên GitHub Container Registry (`ghcr.io`).

Đồng thời, bài thực hành kiểm nghiệm cơ chế tự động hủy/bỏ qua (Skipped) của Job đóng gói Docker khi kiểm thử JUnit bị cố tình làm lỗi.

### 2. Cấu trúc thư mục bài nộp
```text
SS11_HW05_DaoTrongTri_PTIT062/
├── .github/
│   └── workflows/
│       └── ci.yml             # Kịch bản CI/CD gồm 2 Jobs liên kết qua needs: test
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── src/
│   ├── main/
│   │   ├── java/com/ptit/devops_ss11/Application.java
│   │   └── resources/application.properties
│   └── test/
│       └── java/com/ptit/devops_ss11/ApplicationTests.java
├── .gitignore
├── build.gradle
├── Dockerfile                 # Đóng gói ứng dụng chạy trên Temurin 17 JRE Alpine
├── gradlew
├── gradlew.bat
├── settings.gradle
├── README.md                  # Hướng dẫn tổng quan
└── REPORT.md                  # Báo cáo kỹ thuật phân tích DAG, needs và trạng thái Skipped
```

### 3. Cấu hình Job Chaining với `needs: test`
```yaml
jobs:
  test:
    name: Run Unit Tests & Build JAR
    # Các bước test và bootJar...

  docker-build:
    name: Build and Push Docker Image
    needs: test
    runs-on: ubuntu-latest
    # Các bước login registry và build-push image...
```

Chi tiết phân tích cơ chế DAG (Directed Acyclic Graph), sơ đồ Mermaid và hướng dẫn kiểm nghiệm trường hợp Test Failure xem tại [REPORT.md](REPORT.md).
