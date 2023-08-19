output "container-registry-name" {
  value = aws_ecr_repository.ecr.name
}
output "container-registry-id" {
  value = aws_ecr_repository.ecr.registry_id
}
output "container-registry-repository-url" {
  value = aws_ecr_repository.ecr.repository_url
}
output "cloud-watch-name" {
  value = aws_cloudwatch_log_group.logs.name
}
output "container-service-cluster-name" {
  value = aws_ecs_cluster.ecs.name
}
output "redis-cluster-address" {
  value = aws_elasticache_cluster.redis.cluster_address
}
output "opensearch-domain-endpoint" {
  value = aws_opensearch_domain.domain.endpoint
}
output "s3-bucket-name" {
  value = aws_s3_bucket.s3.bucket
}
output "app_url" {
  value = aws_alb.application_load_balancer.dns_name
}