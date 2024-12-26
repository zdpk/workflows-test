#!/usr/bin/env bash

set -e

repo="zdpk/workflows-test"
pr_number="57"

if [ -z "$pr_number" ]; then
    echo "Usage: $0 <pr_number>"
    exit 1
fi

# repo=$(gh repo view --json nameWithOwner -q .nameWithOwner)

labels=$(gh api repos/$repo/issues/$pr_number/labels --jq '.[].name')

echo "labels"
echo "$labels"  


