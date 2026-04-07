#!/bin/bash
set -e  # 오류 발생 시 스크립트 종료

echo "=================================="
echo "---delete_db.sh 파일: 데이터 자료 삭제--"
echo "=================================="

echo "

---삭제 전 inspect_db.sh 파일로 자료 확인할 것---"

DB_TYPE=$1
DB_NAME=$2
TABLE_NAME=$3

if [ "$DB_TYPE" == "postgres" ]; then
    sudo -u postgres psql -d "$DB_NAME" -c "DROP TABLE IF EXISTS $TABLE_NAME;"
    sudo -u postgres psql -c "DROP DATABASE IF EXISTS $DB_NAME;"
elif [ "$DB_TYPE" == "mysql" ]; then
    sudo mysql -u root -e "DROP TABLE IF EXISTS $DB_NAME.$TABLE_NAME;"
    sudo mysql -u root -e "DROP DATABASE IF EXISTS $DB_NAME;"
fi
