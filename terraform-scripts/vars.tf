# ECR Related Variables
variable "container-registry-name" {
  default = "rails-registry"
}


# Redis specific variables/parameters
variable "redis-cluster-name" {
  default = "rails-redis-instance"
}

variable "redis-cluster-node-type" {
  default = "cache.t2.micro"
}

variable "redis-cluster-node-num" {
  default = 1
}

variable "redis-cluster-parameter-group-name" {
  default = "default.redis6.2"
}

variable "redis-cluster-version" {
  default = "6.2"
}

variable "redis-cluster-port" {
  default = 6379
}


# S3
variable "s3-bucket-name" {
  default = "rails-server-bucket"
}

# ECS Cluster 
variable "container-service-name" {
  default = "rails-ecs"
}

# Cloud Watch Service Logs
variable "cloud-watch-log-name" {
  default = "rails-log"
}


# Opensearch Instance Variables
variable "opensearch-domain-name" {
  default = "rails-opensearch-domain"
}


variable "opensearch-domain-engine-version" {
  default = "Elasticsearch_7.10"
}


variable "opensearch-domain-instance-type" {
  default = "t3.small.search"
}

variable "application-name" {
  default = "sharko"
}