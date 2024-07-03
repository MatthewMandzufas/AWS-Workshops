#!/bin/bash  
 
aws cloudfront list-distributions | jq -r '.DistributionList.Items[]|[ .Id, .Status, .Origins.Items[0].DomainName, .Enabled ] | @tsv ' 
