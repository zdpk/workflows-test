#!/usr/bin/env bash

set -e

json='{
    "a": {
        "arr": [1, 2, 3],
        "obj": {
            "aa": 1,
            "bb": 2,
            "cc": 3
        }
    },
    "b": 2,
    "c": 3
}'

echo ===============================
echo [all]
echo $json | jq '.'
echo

echo ===============================
echo [.a]
echo $json | jq '.a'
echo 

echo ===============================
echo [.a.arr]
echo $json | jq '.a.arr'
echo

echo ===============================
echo [.a.obj]
echo $json | jq '.a.obj'
echo


# Array
echo ===============================
echo [.a.arr[0]]
echo $json | jq '.a.arr[0]'
echo

# query

echo ===============================
echo "[.a.arr[] | select(. > 1)]"
echo $json | jq '.a.arr[] | select(. > 1)'
echo