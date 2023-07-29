module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.1"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "test"
  monitoring             = true
  vpc_security_group_ids = ["${module.security-group.security_group_id}"]
  subnet_id              = "${module.vpc.public_subnets[0]}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}