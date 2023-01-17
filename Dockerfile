# STAGE: BUILD
FROM schoolofdevops/maven:spring AS build

WORKDIR /app

COPY . .

RUN mvn package -DskipTests

# STAGE: TEST
FROM build AS test

CMD mvn clean test

# STAGE: RUN
FROM openjdk:8-alpine AS run

COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /run/petclinic.jar

EXPOSE 8080

CMD java -jar /run/petclinic.jar
