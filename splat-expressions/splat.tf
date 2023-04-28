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

resource "aws_instance" "test" {
  count             = 3
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  ami               = "ami-007855ac798b5175e"
  tags              = local.tags
}

output "arns" {
  value = aws_instance.test[0].arn
}