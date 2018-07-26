#!/bin/bash

REPLACE_THIS_WITH_YOUR_S3_BUCKET_NAME="hzchen-private"
REGION="cn-north-1"
STACK="sam-apidemo-staging"

pip install -r requirements.txt -t apidemo/build/ && \
cp apidemo/*.py apidemo/build/ && \

sam validate && \
sam package \
	    --template-file cn_template.yaml \
	        --output-template-file cn_packaged.yaml \
		    --s3-bucket $REPLACE_THIS_WITH_YOUR_S3_BUCKET_NAME \
		    --region $REGION && \

sam deploy \
	    --template-file cn_packaged.yaml \
	        --stack-name $STACK \
		    --capabilities CAPABILITY_IAM \
		        --parameter-overrides Env=staging \
				DeploymentPreference=AllAtOnce \
			--region $REGION && \

aws cloudformation describe-stacks \
	    --stack-name $STACK --query 'Stacks[].Outputs' \
	    --region $REGION
