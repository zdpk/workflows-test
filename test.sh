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
gh pr create --title "[Test] $current_date" --body "This PR appends a character to test.txt"

