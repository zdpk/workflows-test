data=$(yq '.a.b.c' "./a.yaml")

echo "data=$data"

# echo ===============================
yq eval '.a.b.c' "./a.yaml"
data=$(yq '.a.b.c' "./a.yaml")

echo "data=$data"
