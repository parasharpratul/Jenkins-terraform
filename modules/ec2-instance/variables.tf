variable "instance_type" {
  description = "EC2 instance type"
}

variable "key_name" {
  description = "SSH key name"
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
}

variable "security_group_ids" {
  description = "Security group IDs for the instance"
  type        = list(string)
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
}

variable "ami_id" {
  description = "AMI ID for the instance"
}
