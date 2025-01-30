provider "aws" {
  region = var.aws_region
}

module "jenkins_sg" {
  source = "./modules/security-group"

  vpc_id = var.vpc_id
}

module "jenkins_instance" {
  source = "./modules/ec2-instance"

  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = var.subnet_id
  security_group_ids = [module.jenkins_sg.security_group_id]
  ebs_volume_size    = var.ebs_volume_size
}

module "ebs_snapshot" {
  source = "./modules/ebs-snapshot"

  instance_id = module.jenkins_instance.instance_id
  volume_id   = module.jenkins_instance.volume_id
}

