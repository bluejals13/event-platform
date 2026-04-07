#!/bin/bash
set -e

echo "=================================="
echo "--- api-worker-4.sh : API 서버 및 Worker 동시 실행 ---"
echo "=================================="

# 사용자 입력
read -r -p "폴더 경로 : " BASE_DIR
read -r -p "사용할 Spring profile (예: docker): " PROFILE

# =========================
# 1️⃣ API 서버 실행
# =========================
API_DIR="$BASE_DIR/api-server"
echo "Starting API server in $API_DIR with profile: $PROFILE..."
cd "$API_DIR" || { echo "API server directory not found!"; exit 1; }
mvn clean spring-boot:run -Dspring-boot.run.profiles=$PROFILE > "$BASE_DIR/api-server.log" 2>&1 &
API_PID=$!
echo "API server PID: $API_PID"

# 서버 시작 대기
sleep 10
echo "API server should be running. Test at: http://localhost:8080/events"

# =========================
# 2️⃣ Worker 실행
# =========================
WORKER_DIR="$BASE_DIR/worker"
echo "Starting Worker in $WORKER_DIR with profile: $PROFILE..."
cd "$WORKER_DIR" || { echo "Worker directory not found!"; exit 1; }
mvn clean spring-boot:run -Dspring-boot.run.profiles=$PROFILE > "$BASE_DIR/worker.log" 2>&1 &
WORKER_PID=$!
echo "Worker PID: $WORKER_PID"

# =========================
# 3️⃣ 실행 완료 안내
# =========================
echo "--------------------------------------------"
echo "API server PID: $API_PID"
echo "Worker PID: $WORKER_PID"
echo "API server URL: http://localhost:8080/events"
echo "Worker is consuming Kafka messages from 'events' topic."
echo "Logs: $BASE_DIR/api-server.log , $BASE_DIR/worker.log"
echo "Use 'kill $API_PID' and 'kill $WORKER_PID' to stop the processes."
echo "--------------------------------------------"

wait
