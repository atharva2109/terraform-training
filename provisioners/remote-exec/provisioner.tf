provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
  profile    = "default"
}

resource "aws_key_pair" "main" {
  key_name   = "testkey"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "aws_security_group" "main" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "test" {
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = aws_key_pair.main.key_name
  ami               = "ami-007855ac798b5175e"
  security_groups   = ["allow_tls"]
  tags = {
    app_name = "demoapp",
    env_name = "test"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2-bin -y",
      "sudo apt-get install mime-support -y",
      "sudo apt-get install ssl-cert -y",
      "sudo apt-get install apache2 -y",
      "sudo systemctl start apache2",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand("~/.ssh/id_rsa"))
      host        = self.public_ip
    }
  }
}

