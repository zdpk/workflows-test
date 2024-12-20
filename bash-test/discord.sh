#!/usr/bin/env bash

set -e

webhook_url="https://discord.com/api/webhooks/1314158980062380042/5zJ5p79tp3Tb55Kh8EJVIvShXtq6T1TL77QVfoBSMjGUnOzi1NL3D8VVz9wJQ10YcXVv"

curl -s -X POST -H "Content-Type: application/json" \
    -d '{
        "content": "test"
    }' \
    https://discord.com/api/webhooks/1234567890/

json_payload='{
    "embeds": [
        {
            "color": 4494418,
            "title": "**Pull Request Updated**",
            "description": "[PR 보기](${pr_url})\\n${pr_title}",
            "fields": [
                {
                    "name": "Repository",
                    "value": "${{ github.repository }}",
                    "inline": true
                }, 
                {
                    "name": "Branch",
                    "value": "${pr_branch}",
                    "inline": true 
                }
            ],
            "footer": {
                "text": "Updated by ${{ github.actor }} • ${updated_at}"
            }
        }
    ]
}'

# json='{
#     "embeds": [
#         {
#             "color": 4494418,
#             "title": "**Pull Request Updated**",
#             "description": "this is an example Pull Request",
#             "fields": [
#                 {
#                     "name": "Repository",
#                     "value": "https://google.com",
#                     "inline": true
#                 },
#                 {
#                     "name": "Branch",
#                     "value": "'"xx"'",
#                     "inline": true
#                 }
#             ],
#             "footer": {
#                 "text": "Updated by '"x"' • '"$(date)"'",
#                 "icon_url": "https://avatars.githubusercontent.com/u/1234567"
#             }
#         }
#     ],
#     "content": "This is a message with components"
# }'

# json2='{
#     "embeds": [
#         {
#             "color": 4494418,
#             "title": "**Pull Request Updated**",
#             "description": "this is an example Pull Request\\n[PR 보기](https://github.com/YOUR_REPO/pull/YOUR_PR_NUMBER)",
#             "fields": [
#                 {
#                     "name": "Repository",
#                     "value": "https://google.com",
#                     "inline": true
#                 },
#                 {
#                     "name": "Branch",
#                     "value": "'xx'",
#                     "inline": true
#                 }
#             ],
#             "footer": {
#                 "text": "Updated by '"dd"' • '"$(date)"'",
#                 "icon_url": "https://avatars.githubusercontent.com/u/1234567"
#             }
#         }
#     ],
#     "content": "This is a message with components"
# }'
json='{
    "embeds": [
        {
            "color": 4494418,
            "title": "**Pull Request Updated**",
            "description": "this is an example Pull Request",
            "fields": [
                {
                    "name": "Repository",
                    "value": "https://google.com",
                    "inline": true
                },
                {
                    "name": "Branch",
                    "value": "'"xx"'",
                    "inline": true
                }
            ],
            "footer": {
                "text": "Updated by '"x"' • '"$(date)"'",
                "icon_url": "https://avatars.githubusercontent.com/u/1234567"
            }
        }
    ],
    "content": "This is a message with components"
}'

json3='{
    "embeds": [
        {
            "color": 4494418,
            "title": "Pull Request Updated",
            "description": "this is an example Pull Request\n[PR 보기](https://github.com/YOUR_REPO/pull/YOUR_PR_NUMBER)",
            "fields": [
                {
                    "name": "Repository",
                    "value": "https://google.com",
                    "inline": true
                },
                {
                    "name": "Branch",
                    "value": "'xx'",
                    "inline": true
                },
                {
                    "name": "",
                    "value": "[PR 보기](https://github.com/YOUR_REPO/pull/YOUR_PR_NUMBER)",
                    "inline": false
                }
            ],
            "footer": {
                "text": "Updated by '"dd"' • '"$(date)"'",
                "icon_url": "https://avatars.githubusercontent.com/u/1234567"
            }
        }
    ],
    "content": "This is a message with components"
}'

curl -v -X POST -H 'Content-type: application/json' \
    --data "$json3" \
    "$webhook_url"