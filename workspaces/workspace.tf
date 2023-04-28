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
  instance_type     = lookup(var.instance_type, terraform.workspace)
  availability_zone = "us-east-1a"
  ami               = "ami-007855ac798b5175e"
  tags              = local.tags
}

variable "instance_type" {
  type = map(any)
  default = {
    default = "t2.micro",
    dev     = "t2.medium",
    prod    = "t2.large"
  }
}

# default->t2.micro
# dev->t2.medium
# prod->t2.large
