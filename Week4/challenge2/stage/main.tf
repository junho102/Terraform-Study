module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = local.vpc_cidr
  env      = local.env
}

module "subnets" {
  source = "../modules/subnets"
  vpc_id = module.vpc.vpc_id

  env      = local.env
  pub_cidr = local.pub_cidr
  pri_cidr = local.pri_cidr
}

module "gateway" {
  source     = "../modules/gateway"
  vpc_id     = module.vpc.vpc_id
  pub_subnet = module.subnets.pub_subnet

  env = local.env
}

module "routingTable" {
  source     = "../modules/routetables"
  vpc_id     = module.vpc.vpc_id
  igw        = module.gateway.igw
  natgw_az1  = module.gateway.natgw_az1
  pub_subnet = module.subnets.pub_subnet
  pri_subnet = module.subnets.pri_subnet

  env = local.env
}

