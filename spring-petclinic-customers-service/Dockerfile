# 1. Use the official, lightweight Java 17 runtime
FROM eclipse-temurin:17-jre-jammy

# 2. Set the working directory inside the container
WORKDIR /app

# 3. DevSecOps: Create a restricted non-root user to run the app
RUN addgroup --system appadmin && adduser --system --ingroup appadmin appadmin
USER appadmin

# 4. Copy the compiled Java .jar file from the target directory
COPY target/*.jar app.jar

# 5. Expose the port this microservice runs on
EXPOSE 8080

# 6. Command to execute the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]