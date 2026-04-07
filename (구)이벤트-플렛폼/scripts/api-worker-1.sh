#!/bin/bash
set -e

echo "=================================="
echo "--- api-worker-1.sh 파일 : 폴더 경로 및 하위 파일 출력 ---"
echo "=================================="

echo "

---apt 업데이트---"
sudo apt update

echo "

---자바 버전 확인---"
sudo java -version

echo "

---MVN 버전 확인---"
sudo mvn -v

echo "

---도커 버전 확인 및 컴포즈 확인---"
sudo docker --version
sudo docker-compose --version

echo "

---도커 프로세서 확인 및 네트워크 와 플러그인 확인---"
sudo docker ps
sudo docker network ls
sudo docker plugin ls
sudo docker images
echo "

---PostgreSQL 버전 확인---"
sudo psql --version

echo "

---MySQL 버전 확인---"
sudo mysql --version

echo "

---ip 확인---"
sudo ip route
sudo ping -c 3 8.8.8.8

echo "

---ufw 상태, 상세 정보, 번호---"
sudo ufw status verbose numbered



