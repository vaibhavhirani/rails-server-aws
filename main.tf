# S3 for terraform backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
#   backend "s3" {
    
#   }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Elastic Container Registry
resource "aws_ecr_repository" "ecr" {
    name = var.container-registry-name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    } 
}

# AWS Opensearch Instance

# AWS Elastic Cache Redis

# AWS S3 

# Load Balancer

# Elastic Container Service
