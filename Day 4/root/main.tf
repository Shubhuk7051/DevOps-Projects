module "vpc" {
  source="../modules/vpc"
  vpc_cidr= var.vpc_cidr
  pub-sub1-cidr=var.pub-sub1-cidr
  pub-sub2-cidr=var.pub-sub2-cidr
  pri-sub1-cidr=var.pri-sub1-cidr
  pri-sub2-cidr=var.pri-sub2-cidr
  data-pri-sub1-cidr=var.data-pri-sub1-cidr
  data-pri-sub2-cidr=var.data-pri-sub2-cidr
}

module "sg" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
}

# creating Key for instances
module "key" {
  source = "../modules/key"
}

module "alb" {
  source = "../modules/alb"
  alb_sg_id = module.sg.alb_sg_id
  pub_sub1_id = module.vpc.pub_sub1_id
  pub_sub2_id = module.vpc.pub_sub2_id
  vpc_id = module.vpc.vpc_id
  
}

module "asg" {
    source = "../modules/asg"
    key_name=module.key.key_name
    client_sg_id=module.sg.client_sg_id
    pri_sub_1_id=module.vpc.pri_sub1_id
    pri_sub_2_id = module.vpc.pri_sub2_id
    tg_arn = module.alb.tg_arn
}

module "rds"{
  source = "../modules/rds"
  data_pri_sub1_id=module.vpc.data_pri_sub1_id
  data_pri_sub2_id = module.vpc.data_pri_sub2_id
  db_sg_id = module.sg.db_sg_id
  db_username = var.db_username
  db_password = var.db_password
}

module "nat"{
  source = "../modules/nat"
  pub_sub1_id=module.vpc.pub_sub1_id
  pub_sub2_id=module.vpc.pub_sub2_id
  igw_id=module.vpc.igw_id
  vpc_id=module.vpc.vpc_id
  pri_sub1_id=module.vpc.pri_sub1_id
  pri_sub2_id=module.vpc.pri_sub2_id
  data_pri_sub1_id=module.vpc.data_pri_sub1_id
  data_pri_sub2_id=module.vpc.data_pri_sub2_id
  }

  resource "aws_s3_bucket" "multitier_tfstate_s3" {
  bucket = "multitier-sk-bhilai-bucket"
}

resource "aws_dynamodb_table" "multitier_terraform_lock" {
  name           = "multitier_terraform_lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
