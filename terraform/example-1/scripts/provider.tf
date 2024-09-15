# You can set access key and secret key as environment variable
# export AWS_ACCESS_KEY_ID="anaccesskey"
# export AWS_SECRET_ACCESS_KEY="asecretkey"

provider "aws" {
    region = var.aws_region 
}