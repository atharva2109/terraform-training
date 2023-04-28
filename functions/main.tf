provider "aws" {
  access_key = ""
  secret_key = ""
  region = var.region
  profile = "default"
}

locals{
    time=formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}


variable "region"{
    default="us-west-1"
}

variable "tags"{
    type=list
    default=["firstec2","secondec2"]
}

variable "ami"{
    type=map(string)
    default={
        "us-east-1"="ami-06e46074ae430fba6"
        "us-west-1"="ami-09c5c62bac0d0634e"
    }
}

resource "aws_key_pair" "main" {
  key_name   = "test-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "main" {
  ami           = lookup(var.ami,var.region)
  instance_type = "t2.micro"
  count=2

  tags={
    Name=element(var.tags,count.index)
  }
}

output "timestamp" {
  value = local.time
}