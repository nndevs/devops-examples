# terraform {
#     backend "s3" {
#         bucket         = "nndevs-tr-state-locked-bucket"
#         key            = "nndevs/terraform/remote/s3/terraform.tfstate"
#         encrypt        = true
#         region         = "ap-south-1"
#         dynamodb_table = "terraform-state-lock-dynamo"
#     }
# }