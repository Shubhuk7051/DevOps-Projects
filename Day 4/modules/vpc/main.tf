resource "aws_vpc" "sk_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sk_vpc.id

  tags = {
    Name= "my-igw"
  }
}

resource "aws_subnet" "pub-sub-1" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.pub-sub1-cidr
    availability_zone= "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name="pub-sub-1"
    }
}

resource "aws_subnet" "pub-sub-2" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.pub-sub2-cidr
    availability_zone= "us-east-1b"
    map_public_ip_on_launch = true

      tags = {
      Name="pub-sub-2"
    }
}

resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.sk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name="pub-route" 
  }
}
  
resource "aws_route_table_association" "pub-rta-1" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_route_table_association" "pub-rta-2" {
  subnet_id      = aws_subnet.pub-sub-2.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_subnet" "pri-sub-1" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.pri-sub1-cidr
    availability_zone= "us-east-1a"
    map_public_ip_on_launch = false

      tags = {
      Name="pri-sub-1"
    }
}

resource "aws_subnet" "pri-sub-2" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.pri-sub2-cidr
    availability_zone= "us-east-1b"
    map_public_ip_on_launch = false

      tags = {
      Name="pri-sub-2"
    }
}

resource "aws_subnet" "data-pri-sub-1" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.data-pri-sub1-cidr
    availability_zone= "us-east-1a"
    map_public_ip_on_launch = false

      tags = {
      Name="data-pri-sub-1"
    }
}

resource "aws_subnet" "data-pri-sub-2" {
    vpc_id = aws_vpc.sk_vpc.id
    cidr_block = var.data-pri-sub2-cidr
    availability_zone= "us-east-1b"
    map_public_ip_on_launch = false

      tags = {
      Name="data-pri-sub-2"
    }
}



