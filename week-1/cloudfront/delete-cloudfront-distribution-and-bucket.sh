#!/bin/bash 

AWS_PROFILE=j1-sandboxdeveloper
BUCKET_NAME=$1

aws s3 rb "s3://${BUCKET_NAME}" --profile ${AWS_PROFILE}

aws cloudfront delete-distribution //TOOD: --profile ${AWS_PROFILE}

