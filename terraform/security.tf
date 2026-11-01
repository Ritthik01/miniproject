
# --------------------------------------------------
# Security Group for DevOps Project
# --------------------------------------------------

resource "aws_security_group" "web" {
  name        = "${var.project_name}-security-group"
  description = "Allow secure access to DevOps application"
  vpc_id      = data.aws_vpc.default.id

  # SSH access
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  # Flask application access
  ingress {
    description = "Flask application"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  # Grafana dashboard access
  ingress {
    description = "Grafana dashboard"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-security-group"
    Project = var.project_name
  }
}
