# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM maven:3.9.8-eclipse-temurin-21-alpine AS builder
WORKDIR /workdir/server
COPY pom.xml /workdir/server/pom.xml
RUN mvn dependency:go-offline

COPY src /workdir/server/src
RUN mvn install

FROM builder as prepare-production

RUN mkdir -p target/dependency
WORKDIR /workdir/server/target/dependency
RUN jar -xf ../*.jar

FROM eclipse-temurin:21.0.4_7-jre-alpine

COPY set-env.sh usr/local/bin/set-env.sh
# Set timezone to Asia/Ho_Chi_Minh
ENV TZ=Asia/Ho_Chi_Minh
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    chmod +x usr/local/bin/set-env.sh

EXPOSE 8080
VOLUME /tmp

ARG DEPENDENCY=/workdir/server/target/dependency
COPY --from=prepare-production ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=prepare-production ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=prepare-production ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["usr/local/bin/set-env.sh", "java", "-cp", "app:app/lib/*", "com.farukgenc.boilerplate.springboot.SpringBootBoilerplateApplication"]