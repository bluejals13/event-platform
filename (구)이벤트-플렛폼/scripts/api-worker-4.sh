#!/bin/bash
set -e

echo "=================================="
echo "--- api-worker-docker.sh : API 서버 및 Worker Docker 실행 ---"
echo "=================================="

# 사용자 입력
read -r -p "폴더 경로 (예: ~/바탕화면/이벤트-플렛폼): " INPUT_DIR

# 절대 경로로 변환
BASE_DIR=$(eval echo "$INPUT_DIR")

DOCKER_COMPOSE_FILE="$BASE_DIR/infra/docker-compose.yml"

# =========================
# 1️⃣ Docker Compose 실행
# =========================
echo "Starting all containers via Docker Compose..."
docker compose -f "$DOCKER_COMPOSE_FILE" up -d --build

# =========================
# 2️⃣ 상태 확인
# =========================
echo "--------------------------------------------"
echo "API 서버 + Worker + Kafka + DB 모두 컨테이너 실행 완료 ✅"
echo "컨테이너 상태:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
echo "API server URL: http://localhost:8080/events"
echo "Worker is consuming Kafka messages from 'events' topic."
echo "로그 확인:"
echo "  api-server: docker logs -f api-server"
echo "  worker: docker logs -f worker"
echo "컨테이너 종료: docker compose -f $DOCKER_COMPOSE_FILE down"
echo "--------------------------------------------"
