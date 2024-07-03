#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Incorrect number of arguments. Please provide the bucket name."
    exit 1
fi

BUCKET_NAME=$1

if [[ ! "${BUCKET_NAME}" =~ ^[a-z0-9][a-z0-9\.\-]{1,61}[a-z0-9]$ ]]; then
    echo "Bucket names can only consist of lowercase letters, numbers, dots and hyphens, must be between 3 and 63 characters long and must start with a letter or a number"
    exit 2
elif [[ "${BUCKET_NAME}" =~ ^xn--|sthree- ]]; then
    echo "Bucket names cannot start with the prefix 'xn--' or 'sthree-'"
    exit 3
elif [[ "${BUCKET_NAME}" =~ --ol-s3|-s3alias$ ]]; then
    echo "Bucket names cannot end with the suffix '-s3alias' or '--ol-s3'"
    exit 4
elif [[ "${BUCKET_NAME}" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    echo "Bucket names cannot be formatted as an IP address."
    exit 5
elif [[ "${BUCKET_NAME}" =~ \.\. ]]; then
    echo "Bucket names cannot contain two adjacent periods"
    exit 6
fi

exit 0