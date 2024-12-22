rand_branch_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
rand_branch_name2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

if git rev-parse "origin/$rand_branch_name" > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    git switch "$rand_branch_name"
else
    git switch -c "$rand_branch_name"
fi

if git rev-parse "origin/$rand_branch_name" > /dev/null 2>&1; then
    echo "Already exists"
    git switch "$rand_branch_name"
else
    git switch -c "$rand_branch_name"
    echo "$rand_branch_name" > a
    git add .
    git commit -m "a"
    git push origin "$rand_branch_name"
fi

res=$(gh pr list \
    --base "$rand_branch_name1" \
    --head "$rand_branch_name2" \
    --json number,url \
)

echo "res=$res"