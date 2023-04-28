resource "aws_instance" "test" {
  instance_type     = var.instance_type
  availability_zone = "us-east-1a"
  ami               = "ami-007855ac798b5175e"
  tags = {
    app_name = "demoapp",
    env_name = "test"
  }
}
