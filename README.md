# tf-cloud-s3

## Overview

This repository contains Terraform configuration for provisioning AWS S3 buckets and related resources using Terraform Cloud.

## Prerequisites

- Terraform >= 1.0
- AWS account with appropriate credentials
- Terraform Cloud account

## Usage

1. Clone the repository
2. Configure your AWS credentials
3. Set up Terraform Cloud workspace
4. Run `terraform plan` and `terraform apply`

## Features

- S3 bucket creation
- Versioning and encryption options
- Access control and policies
- CloudFront integration support

## Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

## License

MIT
