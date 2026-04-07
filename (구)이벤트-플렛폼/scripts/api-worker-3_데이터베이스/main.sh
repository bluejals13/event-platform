#!/bin/bash
set -e  # 오류 발생 시 스크립트 종료

echo "=================================="
echo "--- main.sh : 사용자 입력값 기반 DB 관리 ---"
echo "=================================="
echo

# -----------------------------
# 사용자 입력
# -----------------------------
read -p "DB 유형 선택 (postgres/mysql): " DB_TYPE
read -p "DB 이름 입력: " DB_NAME
read -p "테이블 이름 입력: " TABLE_NAME
read -p "DB 사용자 입력: " DB_USER
read -s -p "DB 비밀번호 입력: " DB_PASS
echo

DB_HOST="localhost"
if [ "$DB_TYPE" == "mysql" ]; then
    read -p "호스트 입력 (기본 localhost): " TEMP_HOST
    DB_HOST=${TEMP_HOST:-localhost}
fi

echo
echo "실행할 작업 선택:"
echo "1: 생성"
echo "2: 삭제"
echo "3: 확인"
read -p "선택(1/2/3): " ACTION
echo

# -----------------------------
# 액션 수행
# -----------------------------
case $ACTION in
1)
    echo "==> DB/테이블 생성 시작..."
    ./create_db.sh "$DB_TYPE" "$DB_NAME" "$TABLE_NAME" "$DB_USER" "$DB_PASS" "$DB_HOST"
    ;;
2)
    echo "==> DB/테이블 삭제 시작..."
    ./delete_db.sh "$DB_TYPE" "$DB_NAME" "$TABLE_NAME"
    ;;
3)
    echo "==> DB/테이블 확인 시작..."
    ./inspect_db.sh "$DB_TYPE" "$DB_NAME" "$TABLE_NAME"
    ;;
*)
    echo "❌ 잘못된 선택: $ACTION"
    exit 1
    ;;
esac

echo "=== 작업 완료 ✅ ==="
