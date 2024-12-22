#!/usr/bin/env bash

set -e

body=$(cat <<-EOF
    @ ABC
    # EDR
EOF
)

echo "$body"