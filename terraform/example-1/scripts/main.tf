terraform {
    required_version = ">= 1.9.1"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.66.0"
        }
    }
}

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
}

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


resource "aws_key_pair" "access_ec2_instance" {
    key_name = var.acces_key_name
    public_key = file(var.public_key_path)
}