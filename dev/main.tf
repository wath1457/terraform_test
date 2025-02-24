terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
      }
    }
}

provider "aws" {
    region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = "wath1457-tf-example-bucket"
}

resource "aws_s3_bucket_ownership_controls" "example" { # acl 제어를 위해 요구됨
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}