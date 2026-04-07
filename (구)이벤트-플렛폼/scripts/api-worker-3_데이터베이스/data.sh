#!/bin/bash
set -e  # 오류 발생 시 스크립트 종료

echo "=================================="
echo "---data.sh 파일: 데이터 자료 생성--"
echo "=================================="

echo "

---생성 전 inspect_db.sh 파일로 자료 확인할 것---"

DB_CONTAINER=my_postgres

case $1 in
  inspect)
    docker exec -it $DB_CONTAINER psql -U myuser -d mydb_dev -c "\dt"
    ;;
  query)
    docker exec -it $DB_CONTAINER psql -U myuser -d mydb_dev -c "$2"
    ;;
  reset)
    docker compose down -v
    docker compose up -d
    ;;
  *)
    echo "usage: ./db.sh [inspect|query|reset]"
esac
