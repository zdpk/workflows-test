CURRENT_BRANCH=$(git branch --show-current)

TARGET_BRANCH="update-image-tag-xsas"
# --head: target branch(e.g. main)
# --base: source branch
gh pr list --head $CURRENT_BRANCH --base $TARGET_BRANCH

# fetch pr url as json object
gh pr list --head $CURRENT_BRANCH --base $TARGET_BRANCH --json url

# fetch pr url 
gh pr list --head $CURRENT_BRANCH --base $TARGET_BRANCH \
    --json url \
    --jq '.[].url'

    # fetch pr url 
gh pr list --head $CURRENT_BRANCH --base $TARGET_BRANCH \
    --json url \
    --jq '.[] | .url'

    # fetch pr url 
gh pr list --head $CURRENT_BRANCH --base $TARGET_BRANCH \
    --json url \
    --jq '.[0] | .url'