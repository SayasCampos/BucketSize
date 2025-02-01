#!/bin/bash

ORG_IDS=("IDs FROM FILES AND ORGANIZATION")

for ORG_ID in "${ORG_IDS[@]}"
do
  echo "Organization ID: $ORG_ID"

  for PROJECT_ID in $(gcloud projects list --format="value(projectId)" --filter="parent.id=$ORG_ID")
  do
    echo "  Project ID: $PROJECT_ID"

    # Check if project has buckets
    NUM_BUCKETS=$(gsutil ls -p $PROJECT_ID | wc -l)

    if [[ $NUM_BUCKETS -eq 0 ]]; then
      echo "    No buckets"
    else
      # List and analyze buckets
      for BUCKET in $(gsutil ls -p $PROJECT_ID)
      do
       # echo -n "$BUCKET - "
        gsutil du -hs $BUCKET
      done
    fi
  done
done
