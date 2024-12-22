# Go Lambda Terraform

This is a simple example of how to create a scheduled lambda function using Terraform.



## Requirements

* AWS CLI already configured with Administrator permission
* [Docker installed](https://www.docker.com/community-edition)
* [Golang](https://golang.org)
* Terraform

## Setup process

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bootstrap main.go
zip lambda.zip bootstrap
```

## Terraform Commands

```bash
terraform init # Initialize the Terraform project
terraform validate # Validate the Terraform files
terraform plan # Plan the Terraform changes
terraform apply # Apply the Terraform changes
terraform destroy # Destroy the resources created by Terraform
```
