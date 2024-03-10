resource "aws_vpc" "sk_vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.sk_vpc.id
  cidr_block              = "10.0.0.0/24" #Subnet Range"
  availability_zone       = "us-east-1a"  #Availability Zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.sk_vpc.id
  cidr_block              = "10.0.1.0/24" #Subnet Range"
  availability_zone       = "us-east-1b"  #Availability Zone
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.sk_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.sk_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id #Internet Gateway ID
  }
}

#Route Table Association to subnet1
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

#Route Table Association to subnet2
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "web-sg" {
  name   = "webSg"
  vpc_id = aws_vpc.sk_vpc.id

  tags = {
    Name = "mySG"
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "mys3" {
  bucket = "terraform-pro-buc-ket"
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.mys3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.mys3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {

  bucket = aws_s3_bucket.mys3.id
  acl    = "public-read"
}

resource "aws_instance" "webserver_1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data              = base64encode(file("user_data.sh"))
}

resource "aws_instance" "webserver_2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data              = base64encode(file("user_data1.sh"))
}

resource "aws_lb" "alb" {
  name               = "my-first-Alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web-sg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "my_first_target_group" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sk_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "alb_attach1" {
  target_group_arn = aws_lb_target_group.my_first_target_group.arn
  target_id        = aws_instance.webserver_1.id
}

resource "aws_lb_target_group_attachment" "alb_attach2" {
  target_group_arn = aws_lb_target_group.my_first_target_group.arn
  target_id        = aws_instance.webserver_2.id
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_first_target_group.arn
  }

}

output "loadbalancerdns" {
  value = aws_lb.alb.dns_name
}