# To create ec2 instance using AWS provider

# Using a security group
data "aws_security_group" "selected" {
    id = "sg-0694e85b9ac7debb0"
}

# Create an EC2 instance
resource "aws_instance" "web" {
    ami                    = "ami-02b8269d5e85954ef" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    instance_type          = "t3.micro"
    vpc_security_group_ids = [data.aws_security_group.selected.id]
    key_name               = "nipun_key"
    count                  = 0 # Set to 0 to avoid charges; change to 1 to create the instance

    tags = {
        Name = "HelloWorld"
    }
}

# To create a GitHub repository using GitHub provider
resource "github_repository" "example" {
    name        = "learn_terraform"
    description = "A repository created with Terraform"
    visibility  = "public"
    topics      = ["terraform", "infrastructure-as-code", "aws"]
}