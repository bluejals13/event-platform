#!/bin/bash
set -e

echo 
echo

echo "------------------------------------" 
echo "도커-컴포즈.yml 로 실행하는 폴더 "
echo "------------------------------------"
echo
echo "Docker 이미지 안에서 JAR 확인"
echo
docker run --rm -it infra-api-server /bin/sh
echo
echo
ls -l /app.jar
echo 
echo "JAR 직접 실행 테스트"
echo
java -jar target/app.jar
echo 
echo
docker ps
echo
echo
docker logs infra-api-server



