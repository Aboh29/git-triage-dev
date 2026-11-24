terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ==========================================
# S3 BUCKET
# ==========================================

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-infra-bucket-2026-unique123"

  tags = {
    Name        = "My-S3-Bucket"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Block public access to S3 bucket

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ==========================================
# VPC CONFIGURATION
# ==========================================

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "My-Terraform-VPC"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# ==========================================
# OUTPUTS
# ==========================================

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.my_vpc.cidr_block
}
