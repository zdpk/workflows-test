#!/usr/bin/env bash
set -e

json='{
    "jobs": [
        {
            "name": "job1",
            "id": 1,
            "status": "success",
            "steps": null
        },
        {
            "name": "job2",
            "id": 2,
            "status": "success",
            "steps": [1, 2]
        },
        {
            "name": "job3",
            "id": 3,
            "status": "failure"
        }
    ]
}'

echo ===============================
echo filter by status 'success'
echo $json | jq '.jobs[] | select(.status == "success")'
echo

echo ===============================
echo filter by status 'success' and get id
echo $json | jq '.jobs[] | select(.status == "success") | .id'
echo

echo ===============================
echo filter by status 'success' and get id and join by whitespace
echo $json | jq '.jobs[] | select(.status == "success") | .id' \
    | tr '\n' ' '
echo

echo ===============================
echo "filter by steps null(contains null or not exists)"
echo $json | jq '.jobs[] | select(.steps == null)' 
echo

## JQ TO BASH
echo ===============================
echo "bash"
# -c : compact output
# 각 obj를 compact json으로 변환 -> 공백 compress
bash_arr=(
    $(echo $json | jq -c '.jobs[] | select(.steps == null)')
)
echo "${bash_arr}"
echo "${bash_arr[@]}"

echo ===============================
for i in "${bash_arr[@]}"; do
    echo $i
done

# echo ===============================
# jq -c '.jobs[] | select(.steps == null)' <<< $json | while read -r line; do
#     echo $line
# done

# HERE STRING
res=$(jq -c '.jobs[]' <<< $json)
echo ===============================
echo res: $res
echo
echo res[@]: ${res[@]}
# [@]을 붙이면 배열 모든 요소 보여줌(space로 구분된)

res=(
    $(jq -c '.jobs[]' <<< $json)
)
echo ===============================
echo res: $res
echo
echo res[@]: ${res[@]}