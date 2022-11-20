#! /bin/bash

VAR1=$(aws cloudformation create-stack --stack-name S3STACK --template-body file://S3/template.yaml --parameters file://S3/parameters.json --output text )
VAR2=$(aws cloudformation create-stack --stack-name RDSSTACK1 --template-body file://RDS/template.yaml --parameters file://RDS/parameters.json --output text )
aws cloudformation wait stack-create-complete --stack-name $VAR1
echo "S3 Bucket Created"
#---------------------------------------------------RDSSTACK_1
#fetching bucket name
BUCKET_NAME=$(aws cloudformation describe-stacks --stack-name S3STACK --query "Stacks[0].Outputs[0].OutputValue")
BUCKET_NAME=${BUCKET_NAME%*\"}
BUCKET_NAME=${BUCKET_NAME#*\"}
BUCKET_NAME_UPLOAD="s3://${BUCKET_NAME}/"


echo "Uploading to S3 bucket"
aws s3 cp SampleDatabase.zip $BUCKET_NAME_UPLOAD
echo "-------------------------------->"
echo "Uploaded database.zip to s3"
DOWNLOAD_URL="https://${BUCKET_NAME}.s3.amazonaws.com/SampleDatabase.zip"
echo "Download zip from : ${DOWNLOAD_URL}"


echo "Waiting on AWS RDS"
##------------------------------------------------->
aws cloudformation wait stack-create-complete --stack-name $VAR2
echo "MYSQL RDS Created"


DB_HOST=$(aws cloudformation describe-stacks --stack-name RDSSTACK1 --query "Stacks[0].Outputs[0].OutputValue")
echo $DB_HOST
DB_HOST=${DB_HOST%*\"}
echo $DB_HOST
DB_HOST=${DB_HOST#*\"}


### PARAMETERS JSON
echo "setting params for EC2 provisioning"
node params.js $DOWNLOAD_URL $DB_HOST
echo "params configured"
##------------------------------------------------->
echo "provsioning EC2 ..."
EC2=$(aws cloudformation create-stack --stack-name EC2Stack --template-body file://EC2/template.yaml --parameters file://EC2/parameters.json --output text)
echo "EC2 Stack has been initiated : ${EC2}"
echo "Waiting for Succesful Creation"
aws cloudformation wait stack-create-complete --stack-name $EC2
echo "All resources were created succesfully"

