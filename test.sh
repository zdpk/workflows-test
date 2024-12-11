#!/usr/bin/env bash

# Append a character to test.txt
echo "a" >> test.txt

# Get the current date
current_date=$(date)

# Commit the change
git add test.txt
git commit -m "[Test] $current_date"

# Create a pull request
git push origin HEAD

current_branch=$(git rev-parse --abbrev-ref HEAD)

# Create a pull request using curl
curl -u "xezv:$PAT" \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/zdpk/workflows-test/pulls \
    -d '{"title":"[Test] '"$current_date"'","body":"This PR appends a character to test.txt","head":"$current_branch","base":"main"}'

