#!/bin/bash

BUCKET_NAME="aws-workshop-$(uuidgen)"
BUCKET_URI="s3://$BUCKET_NAME"
PROFILE="j1-sandboxdeveloper"
echo $BUCKET_NAME > bucket_name.txt
aws s3 mb "$BUCKET_URI" --profile $PROFILE 
aws s3 website "$BUCKET_URI" --profile $PROFILE --index-document index.html
