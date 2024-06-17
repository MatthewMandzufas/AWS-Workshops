#!/bin/bash

BUCKET_NAME=$1
BUCKET_POLICY_FILE=$(mktemp /tmp/bucket-policy.XXXXXX.json)

cat << EOF > "${BUCKET_POLICY_FILE}"
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicReadGetObject",
			"Effect": "Allow",
			"Principal": "*",
			"Action": [
				"s3:GetObject"
				],
			"Resource": [
				"arn:aws:s3:::${BUCKET_NAME}/*"
				]
		}
	]
}


EOF

aws s3api put-bucket-policy --bucket ${BUCKET_NAME} --policy file://${BUCKET_POLICY_FILE} --profile j1-sandboxdeveloper


rm -f "${BUCKET_POLICY_FILE}"

