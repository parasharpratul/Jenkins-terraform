resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_size = var.ebs_volume_size
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose git
              git clone https://github.com/parasharpratul/Jenkins-terraform.git /opt/jenkins-docker
              cd /opt/jenkins-docker
              docker-compose up -d
              EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
}

output "instance_id" {
  value = aws_instance.jenkins.id
}

output "elastic_ip" {
  value = aws_eip.jenkins_eip.public_ip
}

output "volume_id" {
  value = aws_instance.jenkins.root_block_device[0].volume_id
}
