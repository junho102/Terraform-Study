resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}-vpc-${local.env}-apne2"
  }
}

resource "aws_subnet" "pub_subnet" {
  count             = length(local.pub_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.pub_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id.names[0] : local.zone_id.names[2]

  tags = {
    Name = "${local.project_name}-snet-${local.env}-pub-${((count.index) % 2) == 0 ? "a" : "c"}-apne2"
  }
}

resource "aws_subnet" "primary_pri_subnet" {
  count             = length(local.primary_pri_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.primary_pri_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id.names[0] : local.zone_id.names[2]

  tags = {
    Name = "${local.project_name}-snet-${local.env}-pri-${((count.index) % 2) == 0 ? "a" : "c"}-apne2"
  }
}