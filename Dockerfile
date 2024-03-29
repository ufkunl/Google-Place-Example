#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/e-commerce.jar /usr/local/lib/e-commerce.jar
EXPOSE 8070
ENTRYPOINT ["java","-jar","/usr/local/lib/e-commerce.jar"]
