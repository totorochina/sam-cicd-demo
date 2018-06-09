#!/bin/bash

REPLACE_THIS_WITH_YOUR_S3_BUCKET_NAME="hzchen-private-ore"
REGION="us-west-2"
STACK="sam-apidemo"

pip install -r requirements.txt -t apidemo/build/ && \
cp apidemo/*.py apidemo/build/ && \

sam validate && \
sam package \
	    --template-file template.yaml \
	        --output-template-file packaged.yaml \
		    --s3-bucket $REPLACE_THIS_WITH_YOUR_S3_BUCKET_NAME \
		    --region $REGION && \

sam deploy \
	    --template-file packaged.yaml \
	        --stack-name $STACK \
		    --capabilities CAPABILITY_IAM \
		        --parameter-overrides MyParameterSample=MySampleValue \
			--region $REGION && \

aws cloudformation describe-stacks \
	    --stack-name $STACK --query 'Stacks[].Outputs' \
	    --region $REGION
