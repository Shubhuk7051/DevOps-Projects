resource "aws_security_group" "alb-sg" {
    name="elb-security-group"
    description="security group for elb"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name= "alb-Sg"
    }
}

resource "aws_security_group" "client-sg" {
    name="client-security-group"
    description="Enable http/https access on port 80 for elb"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name= "client-Sg"
    }
}

resource "aws_security_group" "db-sg" {
    name="db-security-group"
    description="Enable mysql access on port 3306 from client sg"
    vpc_id = var.vpc_id

    ingress {
        description = "mysql access"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.client-sg.id]
    }

    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name= "database-Sg"
    }
}