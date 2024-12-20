#!/usr/bin/env bash

set -e

# 화이트리스트에 포함된 브랜치 (삭제되지 않음)
whitelist=("main" "develop")

# 현재 리포지토리의 모든 브랜치를 가져옵니다.
branches=$(gh repo view --json nameWithOwner -q .nameWithOwner | xargs -I {} gh api repos/{}/branches --jq '.[].name')

# 각 브랜치를 확인하고 화이트리스트에 포함되지 않은 경우 삭제합니다.
for branch in $branches; do
    if [[ ! " ${whitelist[@]} " =~ " ${branch} " ]]; then
        echo "Deleting branch: $branch"
        gh api -X DELETE "repos/$(gh repo view --json nameWithOwner -q .nameWithOwner)/git/refs/heads/$branch"
    else
        echo "Skipping branch: $branch"
    fi
done