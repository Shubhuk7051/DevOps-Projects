terraform {
  backend "s3" {
    bucket= "multitier-sk-bhilai-bucket"
    key="multitier/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "multitier_terraform_lock"
  }
}