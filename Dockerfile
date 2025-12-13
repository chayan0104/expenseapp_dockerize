
#--------------------------------------
#Stage 1 - app build
#--------------------------------------
# Maven image
FROM maven:3.9.9-eclipse-temurin-17 AS builder
# Set working directory
WORKDIR /app
# Copy source code from local to container
COPY . /app
# Build application and skip test cases
RUN mvn clean install -DskipTests
#RUN mvn clean package -DskipTests
#--------------------------------------
# Stage 2 - app run
#--------------------------------------
# Import small size java image
FROM openjdk:26-ea-slim
# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar
# Expose application port 
EXPOSE 8080
# Start the application
CMD ["java","-jar","/app/target/expenseapp.jar"]