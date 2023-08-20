# Docker Task that gets the ecr login creds, does docker login, builds and pushes the sharko image to ecr
resource "null_resource" "docker_build_push" {
  provisioner "local-exec" {
    command = <<EOF
	    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.ecr.registry_id}.dkr.ecr.ap-south-1.amazonaws.com
	    docker build -t "${aws_ecr_repository.ecr.repository_url}:${file("../VERSION")}" -f ../Dockerfile ../
	    docker push "${aws_ecr_repository.ecr.repository_url}:${file("../VERSION")}"
	    EOF
  }


  triggers = {
    "run_at" = timestamp()
  }


  depends_on = [
    aws_ecr_repository.ecr,
  ]
}
