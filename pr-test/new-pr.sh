create_base_branch() {
    local branch_name=$1
    git switch -c "$branch_name"
    ehco $(uuidgen) > testfile
    git add .
    git commit -m .
    git push origin "$branch_name"

    echo =======================
    echo base branch diff
    echo $(git diff HEAD^ HEAD)
    echo =======================
}

create_head_branch() {
    echo "current branch: $(git branch --show-current)"
    local branch_name=$1
    # create branch
    git switch -c "$branch_name"
    echo $(uuidgen) >> testfile
    git add .
    git commit -m "test commit"
    git push origin "$branch_name"
    echo =======================
    echo head branch diff
    echo $(git diff HEAD^ HEAD)
    echo =======================
}

# create pr and calc delay when pr is created
create_pr() {
    local base_branch="$1"
    local head_branch="$2"
    
    local now=$(date +"%Y-%m-%d %H:%M:%S.%3N")

    pr_url=$(gh pr create \
        --head "$head_branch" \
        --base "$base_branch" \
        --title "TEST PR $now" \
        --body "TEST PR $now")

    echo "pr created url: $pr_url"
    # pr_number=$(echo "$pr_url" | sed 's|.*/pull/\([0-9]*\)$|\1|')
    # echo "pr_number=$pr_number"
    # echo "pr_url=$pr_url"
}

fetch_pr_info() {
    local base_branch="$1"
    local head_branch="$2"
    local pr_info=$(gh pr list \
        --head "$head_branch" \
        --base "$base_branch" \
        --json url --jq '.[0] | .url')
    
    echo $pr_info
}

delete_branch() {
    local branch_name=$1
    git switch main
    git branch -D "$branch_name"
    git push origin --delete "$branch_name"
}

# rand_branch_name=$(date +%s | sha256sum | base64 | head -c 32)
# target_branch_name="main"

# 시작 시간 기록 (초와 나노초를 분리하여 기록)
# start_time_sec=$(date +%s)
# start_time_nsec=$(date +%N)



# while true; do
#     pr_info=$(fetch_pr_info "$rand_branch_name" "$target_branch_name")
#     # 종료 시간 기록 (초와 나노초를 분리하여 기록)
#     end_time_sec=$(date +%s)
#     end_time_nsec=$(date +%N)

#     # 경과 시간 계산 (밀리초 단위)
#     elapsed_time=$(( (end_time_sec - start_time_sec) * 1000 + (end_time_nsec - start_time_nsec) / 1000000 ))
#     echo "======================================"
#     echo "After $elapsed_time ms from start"
#     echo "======================================"
#     if [[ -n $pr_info ]]; then
#         echo "PR is created: $pr_info"
#         break
#     fi
#     sleep 0.1
# done

# delete_branch "$rand_branch_name"



base="base-$(uuidgen)"
head="head-$(uuidgen)"
create_base_branch "$base"
create_head_branch "$head"
create_pr "$base" "$head"

r=$(fetch_pr_info "$base" "$head")
echo "r=$r"
echo $(gh pr list --base "$base" --head "$head" --json url,number)

r=$(gh pr list \
    --head "$head" \
    --base "$base" \
    --json url,number \
    --jq '.[0]')

r2=$(gh pr list \
    --head "dd" \
    --base "ddd" \
    --json url,number \
    --jq '.[0]')

echo "r=$r"
echo "r2=$r2"

if [[ -z "$r2" || "$r2" == "[]" ]]; then
    echo "isempty"
fi

pr_number=$(echo "$r" | jq -r '.url')
pr_url=$(jq -r '.url' <<< "$r")

echo "pr_number=$pr_number"
echo "pr_url=$pr_url"

body= '
    # TEST
    echo "Test PR"
'

resp=$(gh pr comment "$pr_number" --body "$body")
echo "resp=$resp"

git switch main
