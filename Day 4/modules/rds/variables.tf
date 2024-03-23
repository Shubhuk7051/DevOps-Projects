variable "data_pri_sub1_id"{}
variable "data_pri_sub2_id"{} 
variable "db_name" {
    default = "multitierdb"
}

variable "db_sg_name" {
    default = "multitier-db-sg"
}
variable "db_username" {}
variable "db_password" {}
variable "db_sg_id" {}