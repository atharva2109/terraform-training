provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  profile    = "default"
}

locals {
  tags = {
    app_name = "demoapp",
    env_name = "test"
  }
}
resource "aws_instance" "main" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  ami               = "ami-007855ac798b5175e"
  tags              = local.tags
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
  vpc      = true
}
