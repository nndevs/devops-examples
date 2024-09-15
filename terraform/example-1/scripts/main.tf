# Global config 
terraform {
    required_version = ">= 1.9.1"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.66.0"
        }
    }
}

# Create bucket
# resource "aws_s3_bucket" "state_locked_bucket" {
#     bucket = "nndevs-tr-state-locked-bucket"
#     tags = {
#         name = "State locked bucket"
#     }
# }

# Create DynamoDB
# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#     name = "terraform-state-lock-dynamo"
#     hash_key = "LockID"
#     read_capacity = 20
#     write_capacity = 20

#     attribute {
#         name = "LockID"
#         type = "S"
#     }

#     tags = {
#         name = "state lock dynamodb"
#     }
# }


# Create EC2 instance
resource "aws_instance" "ec2_example" {
    ami = var.aws_ami
    instance_type = var.instance_type
    key_name = var.acces_key_name
    vpc_security_group_ids = [aws_security_group.main.id]

    provisioner "remote-exec" {
        inline = [
            "touch hello.txt",
            "echo Automate AWS infrastructure >> hello.txt"
        ]
    }

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file(var.private_key_path)
        timeout = "4m"
    }

    depends_on = [aws_security_group.main]
}

#Create security group
resource "aws_security_group" "main" {
    egress = [
        {
            cidr_blocks      = [ "0.0.0.0/0", ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        }
    ]

    ingress = [
        {
            cidr_blocks      = [ "0.0.0.0/0", ]
            description      = ""
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        }
    ]
}

# Create Access key pair 
resource "aws_key_pair" "access_ec2_instance" {
    key_name = var.acces_key_name
    public_key = file(var.public_key_path)
}