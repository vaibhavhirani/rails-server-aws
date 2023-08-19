# AWS Opensearch Instance
resource "aws_opensearch_domain" "domain" {
  domain_name    = var.opensearch-domain-name
  engine_version = var.opensearch-domain-engine-version
  cluster_config {
    instance_type = var.opensearch-domain-instance-type
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  tags = {
    Domain = "Rail Server"
  }
}