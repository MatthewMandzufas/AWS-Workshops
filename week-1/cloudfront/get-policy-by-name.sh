#!/bin/bash

POLICY_NAME=$1

ID=$(aws cloudfront list-cache-policies --output json | jq --arg cache_policy_name $POLICY_NAME -r '.CachePolicyList.Items | map({Id: .CachePolicy.Id, Name: .CachePolicy.CachePolicyConfig.Name}) | map(select(.Name == $cache_policy_name)) | .[0].Id')


echo ${ID} > Policy_Id.txt
