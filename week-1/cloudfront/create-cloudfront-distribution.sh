#!/bin/bash 

AWS_PROFILE=j1-sandboxdeveloper
BUCKET_NAME=$1
DISTRIBUTION_CONFIG=$(cat <<JSON
{
	"CallerReference": "cd091d16-247f-4cae-a545-82d30e40ddea",
	"DefaultCacheBehavior": {
		"TargetOriginId": "MyBucket",
		"ViewerProtocolPolicy": "redirect-to-https",
		"AllowedMethods": {
			"Quantity": 2,
			"Items": [
				"GET",
				"HEAD"
			]
		},		
	"CachePolicyId": "dd61202c-3303-491d-8a69-ab502c3c6d27"
	},
	"Origins": {
		"Quantity": 1,
		"Items": [
			{
				"S3OriginConfig": {
				"OriginAccessIdentity": ""
				},
				"Id": "MyBucket",
				"DomainName": "${BUCKET_NAME}.s3.$(aws configure get region).amazonaws.com",
				"CustomHeaders": {
					"Quantity": 0
				}
			}
		]
	},
	"Comment": "CloudFront Distribution For MyBucket",
	"Enabled": true,
	"CacheBehaviors": {
		"Quantity": 1,
		"Items": [
			{
				"PathPattern": "/*",
				"ViewerProtocolPolicy": "redirect-to-https",
				"TargetOriginId": "MyBucket",
				"CachePolicyId": "dd61202c-3303-491d-8a69-ab502c3c6d27"
			}
		]
	}
}
JSON
)

# echo "${DISTRIBUTION_CONFIG}"

aws cloudfront create-distribution --profile ${AWS_PROFILE} --distribution-config="${DISTRIBUTION_CONFIG}" 
