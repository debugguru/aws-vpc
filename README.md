# aws-vpc
Terraform code to create basic AWS VPC. Useful to create basic VPC in ACG Sandbox

## Steps
1. Clone git repo
2. Replace aws_access_key and aws_secret_key in provider.tf with you access and secret key
    ```
    provider "aws" {
    region = var.AWS_REGION
    access_key = "aws_access_key"
    secret_key = "aws_secret_key"
    }
    ```
3. terraform init
4. terraform validate
5. terraform plan
6. terraform apply

