provider "aws" {
  region = "ap-northeast-2"
  alias  = "seoul_region"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "tokyo_region"
}

variable "name" {
  default = "ljh"
}

resource "aws_s3_bucket" "seoul_s3_bucket" {
  provider = aws.seoul_region
  bucket   = "${var.name}-seoul-s3"
}

resource "aws_s3_bucket" "tokyo_s3_bucket" {
  provider = aws.tokyo_region
  bucket   = "${var.name}-tokyo-s3"
}