#!/bin/bash
set -e

echo 
echo

echo "------------------------------------" 
echo "도커-컴포즈.yml 로 실행하는 폴더 "
echo "------------------------------------"
echo
docker compose down
echo 
echo
docker compose build api-server
echo 
echo
docker compose up -d
echo 
echo
docker ps -a
echo
echo
docker logs infra-api-server



