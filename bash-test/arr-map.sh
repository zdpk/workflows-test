#!/usr/bin/env bash

set -e

arr=(1 2 3 4 5)

declare -A mp

for i in "${arr[@]}"; do
    mp[$i]=$((i * i))
done
echo "============================="

# 값만 참조
for i in "${mp[@]}"; do
    echo "$i -> ${mp[$i]}"
done
echo "============================="

# 키를 참조
for i in "${!mp[@]}"; do
    echo "$i -> ${mp[$i]}"
done

echo "============================="
# 키를 정렬하여 참조
for i in $(echo "${!mp[@]}" | tr ' ' '\n' | sort -n); do
    echo "$i -> ${mp[$i]}"
done