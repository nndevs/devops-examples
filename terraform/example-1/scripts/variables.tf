variable "aws_region" {
    default = "ap-south-1"
    type = string
    description = "The AWS region name"
}

variable "aws_ami" {
    default = "ami-0522ab6e1ddcc7055"
    type = string
    description = "This is instance image"
}

variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "Instance type"
}

variable "acces_key_name" {
    default = "aws_key"
    type = string
    description = "AWS EC2 instance access key name"
}

variable "public_key_path" {
    default = "/home/ubuntu/.ssh/aws_key.pub"
    description = "This is public key location"
}

variable "private_key_path" {
    default = "/home/ubuntu/.ssh/aws_key"
    description = "This is private key location"
}