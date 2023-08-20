# ECR Related Variables
variable "container-registry-name" {
  default = "sharko"
}


# Redis specific variables/parameters
variable "redis-cluster-name" {
  default = "sharko-redis-instance"
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
  default = "sharko-server-bucket"
}

# ECS Cluster 
variable "container-service-name" {
  default = "sharko-ecs"
}

# Cloud Watch Service Logs
variable "cloud-watch-log-name" {
  default = "sharko-log"
}


# Opensearch Instance Variables
variable "opensearch-domain-name" {
  default = "sharko-opensearch-domain"
}

# Opensearch Engine Version
variable "opensearch-domain-engine-version" {
  default = "Elasticsearch_7.10"
}


# Opensearch Instance Type
variable "opensearch-domain-instance-type" {
  default = "t3.small.search"
}

variable "application-name" {
  default = "sharko"
}

# S3 Connection Params
variable "AWS_SECRET_ACCESS_KEY" {
  sensitive = true
}

variable "AWS_ACCESS_KEY_ID" {
  sensitive = true
}

# Postgress URL
variable "POSTGRES_HOST" {
description = "Specifies the host name - and optionally port - on which PostgreSQL is running. Multiple hosts may be specified, see the docs for more info. If the value begins with a slash, it is used as the directory for the Unix-domain socket (specifying a Port is still required)."
type = string
}

variable "POSTGRES_PORT" {
description = "The TCP port of the PostgreSQL server."
type = string
default = "5432"
}

variable "POSTGRES_DATABASE" {
description = "The PostgreSQL database to connect to."
type = string
}

variable "POSTGRES_USERNAME" {
description = "The username to connect with. Not required if using IntegratedSecurity."
type = string
}

variable "POSTGRES_PASSWORD" {
description = "The password to connect with. Not required if using IntegratedSecurity."
type = string
}
