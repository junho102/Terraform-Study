data "aws_availability_zones" "az" {
  state = "available"
}

variable "project_tag" {
  description = "project name"
  default     = "test"
}

variable "env" {
  description = "environment"
  default     = "dev"
}

variable "seoul_region" {
  description = "seoul region name"
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR BLOCK : x.x.x.x/x"
  default     = "10.0.0.0/16"
}

variable "pub_cidr" {
  description = "pub CIDR BLOCK : x.x.x.x/x"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "primary_pri_cidr" {
  description = "primary pri CIDR BLOCK : x.x.x.x/x"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


locals {
  project_name       = var.project_tag
  env                = var.env
  vpc_cidr           = var.vpc_cidr
  pub_cidr           = var.pub_cidr
  primary_pri_cidr   = var.primary_pri_cidr
  seoul_region       = var.seoul_region
  zone_id            = data.aws_availability_zones.az
}