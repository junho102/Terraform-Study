variable "env" {}

variable "vpc_id" {}

variable "igw" {}

variable "pub_subnet" {}

variable "pri_subnet" {}

variable "natgw_az1" {}

locals {
  env        = var.env
  vpc_id     = var.vpc_id
  igw        = var.igw
  pub_subnet = var.pub_subnet
  pri_subnet = var.pri_subnet
  natgw_az1  = var.natgw_az1
}