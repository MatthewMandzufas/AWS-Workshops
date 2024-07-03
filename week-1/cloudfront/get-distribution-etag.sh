#!/bin/bash 

AWS_PROFILE="j1-sandboxdeveloper"
DISTRIBUTION_ID=$1

aws cloudfront get-distribution-config --profile ${AWS_PROFILE} --id="${DISTRIBUTION_ID}" | jq -r ". | .ETag"
