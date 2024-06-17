BUCKET_NAME=$1
REGION_NAME=$(aws configure get region --profile j1-sandboxdeveloper)
WEBSITE_URL="http://${BUCKET_NAME}.s3-website-${REGION_NAME}.amazonaws.com"

echo ${WEBSITE_URL} | xclip -selection clipboard 
