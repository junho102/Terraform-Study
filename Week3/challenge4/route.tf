resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "pub-rt" }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_asso_rt" {
  count          = length(aws_subnet.pub_subnet.*.id)
  subnet_id      = element(aws_subnet.pub_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table_public.id
}
