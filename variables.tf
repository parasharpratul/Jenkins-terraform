variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  default     = "my-app-key" 
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  default     = "subnet-0b8102d49a19dcc23" 
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-04165e3d0331db6f8"
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
  default     = 20
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default = "ami-023a307f3d27ea427"
}
