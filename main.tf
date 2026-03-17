terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
    byte_length = 10
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "tf-cloud-${random_id.rand_id.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.demo-bucket.bucket
}
  