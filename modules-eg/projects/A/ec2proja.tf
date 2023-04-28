module "ec2" {
  source = "../../modules/myec2"

  instance_type = "t2.small"
}


output "public_ip" {
  value = module.ec2.public_ip
}
