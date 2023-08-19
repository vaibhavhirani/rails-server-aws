output "container-registry-name" {
  value = aws_ecr_repository.ecr.name
}
output "container-registry-id" {
  value = aws_ecr_repository.ecr.registry_id
}
output "container-registry-repository-url" {
  value = aws_ecr_repository.ecr.repository_url
}

