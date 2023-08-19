resource "null_resource" "docker_build_push" {
  provisioner "local-exec" {
    command = <<EOF
	    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.ecr.registry_id}.dkr.ecr.ap-south-1.amazonaws.com
	    docker build -t "${aws_ecr_repository.ecr.repository_url}:latest" -f ../Dockerfile ../
	    docker push "${aws_ecr_repository.ecr.repository_url}:latest"
	    EOF
  }


  triggers = {
    "run_at" = timestamp()
  }


  depends_on = [
    aws_ecr_repository.ecr,
  ]
}