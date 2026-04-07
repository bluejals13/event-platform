#!/bin/bash
set -e

echo "=================================="
echo "--- api-worker-2.sh 파일 : 폴더 경로 및 하위 파일 출력 ---"
echo "=================================="

# 폴더 입력
read -r -p "폴더 경로 : " TARGET_DIR
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

# 출력 모드 선택
read -r -p "트리=2, ls -l=1 선택 : " C

# 폴더 존재 여부 확인
if [ ! -d "$TARGET_DIR" ]; then
    echo "지정한 폴더가 존재하지 않습니다: $TARGET_DIR"
    exit 1
fi

# 하위 폴더 내용 출력
echo "--- 하위 폴더 내용 ---"
for dir in "$TARGET_DIR"/*/ ; do
    [ -d "$dir" ] || continue
    echo "디렉토리: $dir"

    if [ "$(ls -A "$dir")" ]; then
        if [ "$C" = "2" ]; then
            tree "$dir"
        else
            ls -l "$dir"
        fi
    else
        echo "폴더 비어있음"
    fi
done
