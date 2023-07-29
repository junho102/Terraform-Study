# public subnet
resource "aws_subnet" "pub_subnet" {
  count             = length(local.pub_cidr)
  vpc_id            = local.vpc_id
  cidr_block        = element(local.pub_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id_a : local.zone_id_c

  tags = {
    Name = "${local.env}-pub-subnet-${((count.index) % 2) == 0 ? "a" : "c"}"
  }
}

# private subnet
resource "aws_subnet" "pri_subnet" {
  count             = length(local.pri_cidr)
  vpc_id            = local.vpc_id
  cidr_block        = element(local.pri_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id_a : local.zone_id_c

  tags = {
    Name = "${local.env}-pri-subnet-${((count.index) % 2) == 0 ? "a" : "c"}"
  }
}