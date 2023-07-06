provider "aws" {
  region = "ap-northeast-2"
}

variable "name" {
  default = "ljh"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name}-t101study-tfstate"
}

resource "aws_s3_bucket_versioning" "s3bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.dynamodb_table.name
  description = "The name of the DynamoDB table"
}