# This block specifies the provider and its version
# You can adjust the version as needed and leave this block out to use the latest version
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
    region = "ap-south-1" # Mumbai region
}

# This block specifies the provider and its version
# You can adjust the version as needed and leave this block out to use the latest version
terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.8.3"
    }
  }
}

# Define a variable for GitHub Personal Access Token
# Create a file named 'terraform.tfvars' to set the value of this variable
# terraform.tfvars content: github_pat = "your_personal_access_token_here"
variable "github_pat" {
    description = "GitHub Personal Access Token"
    type        = string
    sensitive   = true
}

# Configure the GitHub Provider
provider "github" {
    token = var.github_pat
}