# VPC for Redis Cluster
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet for Redis Cluster
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "rails"
  }
}

# Subnet Group for Redis Cluster
resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-subnet"
  subnet_ids = [aws_subnet.subnet.id]
}

# AWS Elastic Cache Redis
resource "aws_elasticache_cluster" "redis" {
  cluster_id        = var.redis-cluster-name
  engine            = "redis"
  subnet_group_name = aws_elasticache_subnet_group.redis.name
  node_type         = var.redis-cluster-node-type
  num_cache_nodes   = var.redis-cluster-node-num
  engine_version    = var.redis-cluster-version
  port              = var.redis-cluster-port
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "engine-log"
  }
  depends_on = [aws_cloudwatch_log_group.logs, aws_subnet.subnet]
}
