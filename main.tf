provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  profile = "default"
}


resource "aws_instance" "test" {
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  ami = "ami-007855ac798b5175e"
}

