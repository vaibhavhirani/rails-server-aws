data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Create the ECS Service which contains the app-task along with side-tasks as well.
resource "aws_ecs_service" "ecs" {
  name            = "${var.application-name}"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 3
  launch_type = "FARGATE"
  
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn 
    container_name   = aws_ecs_task_definition.app_task.family
    container_port   = 3000 
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = true                                                
    security_groups  = ["${aws_security_group.service_security_group.id}"] 
  }

  depends_on = [
    aws_ecs_cluster.ecs
  ]
}

resource "aws_ecs_task_definition" "app_task" {
  family = "${var.application-name}"
  container_definitions = <<DEFINITION
  [
    {
      "name"      : "${var.application-name}",
      "image"     : "${aws_ecr_repository.ecr.repository_url}:latest",
      "environment": [
        {"name": "REDIS_URL", "value": "${aws_elasticache_cluster.redis.cluster_address}"},
        {"name": "REDIS_PORT", "value": "${var.redis-port}"},
        {"name": "ELASTIC_SEARCH", "value": "${aws_opensearch_domain.domain.endpoint}"},
        {"name": "S3_BUCKET", "value": "${aws_s3_bucket.s3.bucket}"},
        {"name": "AWS_ACCESS_KEY_ID,", "value": "${var.AWS_ACCESS_KEY_ID}"},
        {"name": "AWS_SECRET_ACCESS_KEY,", "value": "${var.AWS_SECRET_ACCESS_KEY}"},
        {"name": "POSTGRES_HOST", "value": ""${var.POSTGRES_HOST}"}, 
        {"name": "POSTGRES_PORT", "value": ""${var.POSTGRES_PORT}"}, 
        {"name": "POSTGRES_DATABASE", "value": ""${var.POSTGRES_DATABASE}"}, 
        {"name": "POSTGRES_USERNAME", "value": ""${var.POSTGRES_USERNAME}"}, 
        {"name": "POSTGRES_PASSWORD", "value": ""${var.POSTGRES_PASSWORD}"}, 
      ],
      "portMappings" : [
        {
          "containerPort" : 3000,
          "hostPort"      : 3000
        }
      ]
    }
  ]
  DEFINITION
  # using Fargate as the launch type. It is a serverless offering.
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = 512         
  cpu                      = 256     
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  depends_on = [ null_resource.docker_build_push ]
}

# Creates an IAM Role 
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole-${var.application-name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Attaches role and policy 
resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}