# S3 for terraform backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Elastic Container Registry
resource "aws_ecr_repository" "ecr" {
  name                 = var.application-name
  force_delete = true 
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}


# Elastic Container Service
resource "aws_ecs_cluster" "ecs" {
  name = var.container-service-name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.logs.name
      }
    }
  }
  depends_on = [ aws_ecr_repository.ecr ]
}

# Cloud Watch Logs
resource "aws_cloudwatch_log_group" "logs" {
  name = var.cloud-watch-log-name
}

# AWS S3 
resource "aws_s3_bucket" "s3" {
  bucket = var.s3-bucket-name
  tags = {
    Name = var.s3-bucket-name
  }

}
