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
    name = var.container-registry-name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
}

# AWS Elastic Cache Redis
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis-cluster-name
  engine               = "redis"
  node_type            = var.redis-cluster-node-type
  num_cache_nodes      = var.redis-cluster-node-num
  parameter_group_name = var.redis-cluster-parameter-group-name
  engine_version       = var.redis-cluster-version
  port                 = var.redis-cluster-port
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
  depends_on = [ aws_cloudwatch_log_group.logs ]
}

# AWS S3 
resource "aws_s3_bucket" "s3" {
  bucket = var.s3-bucket-name
  tags = {
    Name        = var.s3-bucket-name
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
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name = aws_cloudwatch_log_group.logs.name
      }
    }
  }
}

# Cloud Watch Logs
resource "aws_cloudwatch_log_group" "logs" {
  name = var.cloud-watch-log-name
}