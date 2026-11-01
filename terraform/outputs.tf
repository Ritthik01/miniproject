
# --------------------------------------------------
# EC2 Instance Outputs
# --------------------------------------------------

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IPv4 address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web.public_dns
}

output "availability_zone" {
  description = "Availability Zone where EC2 is launched"
  value       = aws_instance.web.availability_zone
}

output "security_group_id" {
  description = "Security Group attached to EC2"
  value       = aws_security_group.web.id
}
