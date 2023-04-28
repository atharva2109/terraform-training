provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  profile    = "default"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "allow_tls"
  }
}

variable "ingress" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8202, 8203]
}
