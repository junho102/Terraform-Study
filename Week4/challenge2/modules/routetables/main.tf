####### public routing table #######
resource "aws_route_table" "route_table_public" {
  vpc_id = local.vpc_id
  tags   = { Name = "${local.env}-public-rt" }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.igw.id
}

resource "aws_route_table_association" "public_asso_rt" {
  count          = length(local.pub_subnet[*].id)
  subnet_id      = element(local.pub_subnet[*].id, count.index)
  route_table_id = aws_route_table.route_table_public.id
}


####### private routing table #######
resource "aws_route_table" "route_table_private" {
  vpc_id = local.vpc_id
  tags   = { Name = "${local.env}-private-rt" }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.natgw_az1.id
}

resource "aws_route_table_association" "private_asso_rt" {
  count          = length(local.pri_subnet[*].id)
  subnet_id      = element(local.pri_subnet[*].id, count.index)
  route_table_id = aws_route_table.route_table_private.id
}
