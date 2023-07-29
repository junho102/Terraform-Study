variable "env" {}

variable "pub_subnet" {}

variable "vpc_id" {

}

locals {
  env        = var.env
  pub_subnet = var.pub_subnet
  vpc_id     = var.vpc_id
}