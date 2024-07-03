#!/bin/bash 

BUCKET_NAME=$1
aws cloudfront list-distributions | jq -r '.DistributionList.Items[]|[ .Id, .Status, .Origins.Items[0].DomainName, .Enabled ] | @tsv ' | awk '$3=="'${BUCKET_NAME}'.s3.ap-southeast-2.amazonaws.com"'
