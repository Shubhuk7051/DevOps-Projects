output "client_sg_id" {
  value = aws_security_group.client-sg.id
}

output "db_sg_id" {
  value = aws_security_group.db-sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb-sg.id
}