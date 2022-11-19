# Cloudformation Devops
## Tasks
-[x] Deploy an EC2 instance which will "fetch MySQL data dump" from an S3 bucket.

-[x] Instance is required to "fetch the data" from the S3 bucket and then write it to an RDS database. 

-[x] After the data has been transferred, the instance should change its state from Running to Stopped. 

## Aim
1. Develop Seperate Cloudfromation templates in yaml for each service involved
2. Create parameter files for each Cloudformation template.
3. Develop a bash script that deploys the Cloudformation templates using parameters from the parameter files

## Architecture Diagram
