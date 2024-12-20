create_test_branch() {
    local branch_name=$1
    # create branch
    git switch -c "$branch_name"
    echo test > testfile
    git add .
    git commit -m "test commit"
    git push origin "$branch_name"
}

# create pr and calc delay when pr is created
create_pr() {
    local head_branch="$1"
    local base_branch="$2"
    
    local now=$(date +"%Y-%m-%d %H:%M:%S.%3N")

    gh pr create \
        --head "$HEAD_BRANCH" \
        --base "$BASE_BRANCH" \
        --title "TEST PR $now" \
        --body "TEST PR $now"
}

fetch_pr_info() {
    local head_branch="$1"
    local base_branch="$2"
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

rand_branch_name=$(date +%s | sha256sum | base64 | head -c 32)
target_branch_name="main"

start_time=$(date +%s%3N)
create_test_branch "$rand_branch_name"
create_pr "$rand_branch_name" "$target_branch_name"

while true; do
    pr_info=$(fetch_pr_info "$rand_branch_name" "$target_branch_name")
    end_time=$(date +%s%3N)
    elapsed_time=$((end_time - start_time))
    echo "After $elapsed_time ms from start"
    if [[ -n $pr_info ]]; then
        echo "PR is created: $pr_info"
        break
    fi
    sleep 0.1
done

delete_branch "$rand_branch_name"



