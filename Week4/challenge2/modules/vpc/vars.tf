variable "env" {}

variable "vpc_cidr" {}

locals {
  vpc_cidr = var.vpc_cidr
  env      = var.env
}