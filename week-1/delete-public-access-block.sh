#!/bin/bash

BUCKET_NAME=$1
aws s3api delete-public-access-block --bucket $BUCKET_NAME --profile j1-sandboxdeveloper
