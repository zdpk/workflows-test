
# 1. 



function fetch_jobs() {
    jobs=$(gh api /repos/${{ github.repository }}/actions/runs/${{ github.run_id }}/jobs \
        --jq '.jobs[]
        | select(.name != "monitor" and .steps == null)' \
        | jq -c '.')

    echo $jobs
}

jobs=$(fetch_jobs)
should_run=true

while should_run; do
    jobs=$(fetch_jobs)
    for job in $jobs; do
        status=$(jq -r '.status' <<< $job)
        if [[ $status == "failure" ]]; then
            should_run=false
            break
        fi
        echo $job
    done
done

for job in jobs; do
    echo $job
    gh api -X POST /repos/${{ github.repository }}/actions/jobs/$job_id/cancel
done
# 1. fetch all jobs

# 2. check if it's failure if should_run is true

# 3. if it's failure, exit all the jobs