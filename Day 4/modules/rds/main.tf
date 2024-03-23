resource "aws_db_subnet_group" "multitier-db-sg" {
  name       = var.db_sg_name
  subnet_ids = [var.data_pri_sub1_id, var.data_pri_sub2_id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "multitier-db-instance" {
    identifier              = "multitier-db-instance"
    allocated_storage       = 20
    db_name                 = var.db_name
    engine                  = "mysql"
    engine_version          = "5.7"
    instance_class          = "db.t3.micro"
    username                = var.db_username
    password                = var.db_password
    multi_az                = true
    storage_type            = "gp2"
    storage_encrypted       = false
    publicly_accessible     = false
    skip_final_snapshot     = true
    backup_retention_period = 0

    vpc_security_group_ids = [var.db_sg_id]
    db_subnet_group_name = aws_db_subnet_group.multitier-db-sg.name

    tags={
        Name= "MultitierDB"
    }
}