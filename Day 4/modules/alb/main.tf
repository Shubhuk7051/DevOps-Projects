# Create application load balancer
resource "aws_lb" "multitier-alb" {
  name               = "multitier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.pub_sub1_id, var.pub_sub2_id ]
  enable_deletion_protection = false

  tags={
    Name="multitier-alb"
  }
}

# Create target group
resource "aws_lb_target_group" "multitier-alb-tg" {
  name     = "multitier-alb-tg"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    interval = 300
    path= "/"
    timeout = 60
    matcher = 200
    healthy_threshold = 2
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a listener on port 80 with redirect action
resource "aws_lb_listener" "multitier-alb-listener" {
  load_balancer_arn = aws_lb.multitier-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.multitier-alb-tg.arn
  }
}