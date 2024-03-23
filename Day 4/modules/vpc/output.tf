output "vpc_id"{
    value = aws_vpc.sk_vpc.id
}

output "igw_id"{
    value = aws_internet_gateway.igw.id
}

output "pub_sub1_id"{
    value = aws_subnet.pub-sub-1.id
}

output "pub_sub2_id"{
    value = aws_subnet.pub-sub-2.id
}

# Private Subnets 

output "pri_sub1_id"{
    value = aws_subnet.pri-sub-1.id
}

output "pri_sub2_id"{
    value = aws_subnet.pri-sub-2.id
}

output "data_pri_sub1_id" {
  value = aws_subnet.data-pri-sub-1.id
}

output "data_pri_sub2_id" {
  value = aws_subnet.data-pri-sub-2.id
}