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
  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
  tags = {
    Domain = "Rail Server"
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream",
    ]

    resources = ["arn:aws:logs:*"]
  }
}
resource "aws_cloudwatch_log_resource_policy" "cloudwatchpolicy" {
  policy_name     = "cloudwatchpolicy"
  policy_document = data.aws_iam_policy_document.policy.json
}
