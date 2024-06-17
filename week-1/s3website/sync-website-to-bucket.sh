#!/bin/bash 

BUCKET_NAME=$1
BUCKET_URI="s3://${BUCKET_NAME}"
aws s3 sync ./website ${BUCKET_URI} --profile j1-sandboxdeveloper


