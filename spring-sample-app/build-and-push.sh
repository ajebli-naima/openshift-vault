#!/bin/bash
mvn -DskipTests clean install
docker build -t spring-sample-app:latest .
docker push spring-sample-app:latest
