# To create ec2 instance using AWS provider

# Using a security group
data "aws_security_group" "selected" {
    id = "sg-0694e85b9ac7debb0"
}

# Create an EC2 instance
resource "aws_instance" "app_server" {
    ami                    = var.ami_os
    instance_type          = var.instance_type_size
    vpc_security_group_ids = [data.aws_security_group.selected.id]
    key_name               = "nipun_key"
    count                  = 0 # Set to 0 to avoid charges; change to 1 to create the instance

    tags = {
        Name = "Terraform-EC2-Instance-Demo"
    }

    root_block_device {
        volume_size           = var.storage_volume_size
        volume_type           = var.storage_volume_type
        delete_on_termination = var.delete_on_termination_choice
    }

    ebs_block_device {
        device_name           = "/dev/sdh"
        volume_size           = var.storage_volume_size
        volume_type           = var.storage_volume_type
        encrypted             = true
        delete_on_termination = var.delete_on_termination_choice
    }
}

resource "aws_s3_bucket" "app_bucket" {
    bucket = var.bucket_name
    count  = 0 # Set to 0 to avoid charges; change to 1 to create the bucket

    tags = {
        Name        = "Terraform-S3-Bucket-Demo"
        Environment = "Dev"
    }
}

# To create a GitHub repository using GitHub provider
resource "github_repository" "example" {
    name        = "learn_terraform"
    description = "A repository created with Terraform"
    visibility  = "public"
    topics      = ["terraform", "infrastructure-as-code", "aws"]
}