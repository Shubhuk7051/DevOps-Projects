# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1
resource "aws_eip" "eip-nat-1" {
  vpc=true

  tags={
    Name="eip-nat-1 "
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-2
resource "aws_eip" "eip-nat-2" {
  vpc=true

  tags={
    Name="eip-nat-2"
  }
}

# create nat gateway in public subnet pub-sub-1
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip-nat-1.id
  subnet_id     = var.pub_sub1_id

  tags = {
    Name = "nat-1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

# create nat gateway in public subnet pub-sub-2
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.eip-nat-2.id
  subnet_id     = var.pub_sub2_id

  tags = {
    Name = "nat-2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

# create private route table Pri-RT-1 and add route through NAT-GW-1
resource "aws_route_table" "pri_1_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "pri_1_rt"
  }
}

# associate private subnet pri-sub-1 with private route table Pri-RT-1
resource "aws_route_table_association" "pri_1_rta" {
  subnet_id      = var.pri_sub1_id
  route_table_id = aws_route_table.pri_1_rt.id
}

# associate private subnet pri-sub-2 with private route table Pri-RT-1
resource "aws_route_table_association" "pri_2_rta" {
  subnet_id      = var.pri_sub2_id
  route_table_id = aws_route_table.pri_1_rt.id
}

# create private route table Data-Pri-RT and add route through NAT-GW-2
resource "aws_route_table" "data_pri_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-2.id
  }

  tags = {
    Name = "data_pri_rt"
  }
}

# associate private subnet data-pri-sub-1 with private route table Data-Pri-RT
resource "aws_route_table_association" "data_pri_1_rta" {
  subnet_id      = var.data_pri_sub1_id
  route_table_id = aws_route_table.data_pri_rt.id
}

# associate private subnet data-pri-sub-2 with private route table Data-Pri-RT
resource "aws_route_table_association" "data_pri_2_rta" {
  subnet_id      = var.data_pri_sub2_id
  route_table_id = aws_route_table.data_pri_rt.id
}
