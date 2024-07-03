#!/bin/bash

BUCKET_NAME=$1

ID=$(aws cloudfront list-distributions --profile j1-sandboxdeveloper | jq -r --arg bucketName "${BUCKET_NAME}.s3.ap-southeast-2.amazonaws.com" '.DistributionList.Items[] | select(.Origins.Items[] | .DomainName == $bucketName) | .Id')

# echo ${ID} 

sleep 3

DISTRIBUTION_CONFIG=$(aws cloudfront get-distribution --profile j1-sandboxdeveloper --id=${ID} | jq '.Distribution.DistributionConfig.Enabled = false | .Distribution.DistributionConfig') 



ETAG=$(aws cloudfront get-distribution --id ${ID} --profile j1-sandboxdeveloper | jq -r '.ETag')

sleep 3

# echo ${ETAG}

OUTPUT=$(aws cloudfront update-distribution --id="${ID}" --if-match="${ETAG}" --profile j1-sandboxdeveloper --distribution-config="${DISTRIBUTION_CONFIG}")


echo ${OUTPUT} | jq '.ETag' > Distribution_Etag.txt

