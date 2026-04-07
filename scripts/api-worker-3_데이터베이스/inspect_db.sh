#!/bin/bash
set -e  # 오류 발생 시 스크립트 종료

echo "=================================="
echo "---inspect_db.sh 파일: 데이터 자료 식별--"
echo "=================================="
echo 
echo 
echo "서버 내 존재하는 모든 DB 목록 확인"
sudo -u postgres psql -l
echo "

"

echo "DB 유형 선택 (postgres/mysql): "
read DB_TYPE
echo "DB 이름 입력: "
read DB_NAME

# -----------------------------
# PostgreSQL 처리
# -----------------------------
if [ "$DB_TYPE" == "postgres" ]; then
    echo "=== PostgreSQL: DB 존재 여부 확인 ==="
    DB_EXIST=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
    if [ "$DB_EXIST" == "1" ]; then
        echo "DB '$DB_NAME' 존재 ✅"
        echo "=== 테이블 목록 ==="
        TABLES=$(sudo -u postgres psql -d "$DB_NAME" -t -c "SELECT tablename FROM pg_tables WHERE schemaname='public';")
        if [ -z "$TABLES" ]; then
            echo "테이블 없음 ❌"
        else
            for T in $TABLES; do
                echo "--- 테이블: $T ---"
                sudo -u postgres psql -d "$DB_NAME" -c "SELECT * FROM $T LIMIT 20;"
            done
        fi
    else
        echo "DB '$DB_NAME' 없음 ❌"
    fi

# -----------------------------
# MySQL 처리
# -----------------------------
elif [ "$DB_TYPE" == "mysql" ]; then
    echo "=== MySQL: DB 존재 여부 확인 ==="
    DB_EXIST=$(sudo mysql -u root -sse "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$DB_NAME'")
    if [ "$DB_EXIST" == "$DB_NAME" ]; then
        echo "DB '$DB_NAME' 존재 ✅"
        echo "=== 테이블 목록 ==="
        TABLES=$(sudo mysql -u root -sN -e "USE $DB_NAME; SHOW TABLES;")
        if [ -z "$TABLES" ]; then
            echo "테이블 없음 ❌"
        else
            for T in $TABLES; do
                echo "--- 테이블: $T ---"
                sudo mysql -u root -e "USE $DB_NAME; SELECT * FROM $T LIMIT 20;"
            done
        fi
    else
        echo "DB '$DB_NAME' 없음 ❌"
    fi

else
    echo "지원하지 않는 DB 유형: $DB_TYPE"
    exit 1
fi

echo "=== 모든 테이블 데이터 확인 완료 ✅ ==="
