# devops-examples
Automate AWS infrastructure setup using Terraform & Jenkins & GitHub

Target
-----------

1. We will store terraform state file to aws s3 and dynamodb for the state lock.
2. We will create AWS EC2 instance and upload state file to S3 bucket using automation
3. We will use Jenkins to automate

Pre-requisites:
- We need Terraform script to create infrastructure
- Create S3 bucket for storing TF state
- Create dynamo DB table for providing lock capability (Partition key will "LockID")
- Jenkins is up and running
- Terraform is installed in Jenkins
- Terraform files already created in your SCM
- Make sure you have necessary IAM role created with right policy and attached to Jenkins EC2 instance. see below for the steps to create IAM role.
- Create a new jenkens pipeline