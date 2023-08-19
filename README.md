# rails-server-aws
Terraform script that provides all required infrastructure and deploys the Docker image with Rails application to the AWS Elastic Container Registry.

## Setting up AWS authentication for Terraform Resource Provisioning
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
```