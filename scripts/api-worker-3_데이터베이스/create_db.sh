#!/bin/bash
set -e  # 오류 발생 시 스크립트 종료

echo "=================================="
echo "---create_db.sh 파일: 데이터 자료 생성--"
echo "=================================="

echo "

---생성 전 inspect_db.sh 파일로 자료 확인할 것---"




DB_TYPE=$1      # postgres / mysql
DB_NAME=$2
TABLE_NAME=$3
DB_USER=$4
DB_PASS=$5
DB_HOST=${6:-localhost}
TABLE_OPTIONS=${7:-""}

if [ "$DB_TYPE" == "postgres" ]; then
    sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
    sudo -u postgres psql -d "$DB_NAME" -c "CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASS';"
    sudo -u postgres psql -d "$DB_NAME" -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"
    sudo -u postgres psql -d "$DB_NAME" -c "CREATE TABLE IF NOT EXISTS $TABLE_NAME (id VARCHAR(36) PRIMARY KEY, type VARCHAR(50), payload TEXT) $TABLE_OPTIONS;"
elif [ "$DB_TYPE" == "mysql" ]; then
    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    sudo mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASS';"
    sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST'; FLUSH PRIVILEGES;"
    sudo mysql -u root -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS $TABLE_NAME (id VARCHAR(36) PRIMARY KEY, type VARCHAR(50), payload TEXT) $TABLE_OPTIONS;"
fi
