#!/bin/bash 

BUCKET_NAME=$1
BUCKET_URI="s3://${BUCKET_NAME}"

aws s3 rb "${BUCKET_URI}" --force --profile j1-sandboxdeveloper


