
variable "aws_region" {
  description = "AWS region for the project"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "miniproject"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "Your public IP address in CIDR notation"
  type        = string
}

variable "root_volume_size" {
  description = "EC2 root volume size in GB"
  type        = number
  default     = 10
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}
