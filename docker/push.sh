#!/usr/bin/env bash

set -e

# 현재 날짜와 시간을 가져옵니다.
current_date=$(date +"%Y-%m-%d %H:%M:%S")

# 날짜와 시간을 해시로 변환합니다.
hash=$(echo -n "$current_date" | sha256sum | awk '{print $1}')

ECR_REPOSITORY_URL="354918403169.dkr.ecr.ap-northeast-2.amazonaws.com/simplelaw-d-apne2-simplelaw"
BUILDCACHE_TAG="buildcache"
ARTIFACT_NAME="$hash.tar.gz"
# AWS ECR 로그인
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin $ECR_REPOSITORY_URL

# Docker Buildx 빌더 설정

# Docker 이미지 빌드 및 캐시 사용
docker buildx build \
    --platform linux/arm64 \
    --cache-from type=registry,ref=$ECR_REPOSITORY_URL:$BUILDCACHE_TAG \
    --cache-to type=registry,image-manifest=true,oci-mediatypes=true,ref=$ECR_REPOSITORY_URL:$BUILDCACHE_TAG,mode=max \
    --provenance=false \
    --tag $ECR_REPOSITORY_URL:$hash \
    --push .

# Docker 이미지 저장
# docker save $IMAGE | gzip > $ARTIFACT_NAME