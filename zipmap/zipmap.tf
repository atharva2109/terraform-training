provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  profile    = "default"
}

resource "aws_instance" "main" {
  count             = 3
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  ami               = "ami-007855ac798b5175e"
  tags = {
    app_name = "demoapp",
    env_name = "test"
  }
}


output "arns" {
  value = aws_instance.main[*].arn
}

output "instance_state" {
  value = aws_instance.main[*].instance_state
}


output "combined" {
  value = zipmap(aws_instance.main[*].arn, aws_instance.main[*].instance_state)
}
