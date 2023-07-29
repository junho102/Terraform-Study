variable "env" {}

variable "vpc_id" {}

variable "pub_cidr" {}

variable "pri_cidr" {}

data "aws_availability_zones" "az" {
  state = "available"
}

locals {
  env       = var.env
  vpc_id    = var.vpc_id
  pub_cidr  = var.pub_cidr
  pri_cidr  = var.pri_cidr
  zone_id_a = data.aws_availability_zones.az.names[0]
  zone_id_c = data.aws_availability_zones.az.names[2]
}