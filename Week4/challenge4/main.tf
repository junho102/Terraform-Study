module "vpc" {
  source  = "app.terraform.io/jh-proj/vpc/aws"
  version = "1.0.0"

  vpc_cidr     = "10.0.0.0/16"
  company_name = "mzc"
  server_env   = "dev"
}