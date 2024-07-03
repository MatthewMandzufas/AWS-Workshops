#!/bin/bash 

BUCKET_NAME=$1

ID=$(aws cloudfront list-distributions --profile j1-sandboxdeveloper | jq -r --arg bucketName "${BUCKET_NAME}.s3.ap-southeast-2.amazonaws.com" '.DistributionList.Items[] | select(.Origins.Items[] | .DomainName == $bucketName) | .Id')

sleep 3

ETAG=$(./get-distribution-etag.sh ${ID})

sleep 3

aws cloudfront delete-distribution --id="${ID}" --if-match="${ETAG}" --profile j1-sandboxdeveloper

sleep 3

# aws s3 rb s3://${BUCKET_NAME} --force --profile j1-sandboxdeveloper

