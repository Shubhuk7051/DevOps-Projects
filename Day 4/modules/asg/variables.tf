variable ami{
    default = "ami-080e1f13689e07408"
}

variable "instance" {
    default = "t2.micro"
}

variable key_name {}

variable "client_sg_id" {}

variable "max_size" {
  default = 5
}

variable "min_size" {
  default = 2
}

variable "desired_capacity" {
  default = 3
}

variable "health_check_type" {
  default = "ELB"
}

variable "pri_sub_1_id" {}
variable "pri_sub_2_id" {}
variable "tg_arn" {}

