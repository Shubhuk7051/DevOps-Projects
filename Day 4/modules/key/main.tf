resource "aws_key_pair" "demo_key" {
  key_name="demo_key"
  public_key = file("${path.module}/demo_key.pub")
}