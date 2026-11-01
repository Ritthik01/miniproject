
# --------------------------------------------------
# 1. Discover the existing Default VPC
# --------------------------------------------------

data "aws_vpc" "default" {
  default = true
}


# --------------------------------------------------
# 2. Discover Default Subnets
# --------------------------------------------------

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}


# --------------------------------------------------
# 3. Discover the Latest Ubuntu 24.04 LTS AMI
# --------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# --------------------------------------------------
# 4. Create EC2 Instance
# --------------------------------------------------

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = sort(data.aws_subnets.default.ids)[0]
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = file("${path.module}/userdata.sh")

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "${var.project_name}-ec2"
    Project = var.project_name
  }
}
