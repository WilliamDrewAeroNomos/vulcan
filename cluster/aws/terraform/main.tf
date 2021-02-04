// Provider

provider "aws" {
  region = var.AWS_REGION
}

data "aws_ami" "swf-jumpbox-image" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "tag:component-name"
    values = ["swf-jumpbox"]
  }
}

output "swf-jumpbox-ami-id" {
  value = data.aws_ami.swf-jumpbox-image.id
}

// VPC
resource "aws_vpc" "swf-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "swf-vpc",
    namespace = "software-factory",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// Subnet
resource "aws_subnet" "swf-subnet" {
  cidr_block = cidrsubnet(aws_vpc.swf-vpc.cidr_block, 3, 1)
  vpc_id = aws_vpc.swf-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "swf-subnet",
    namespace = "software-factory",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// Security Group
resource "aws_security_group" "swf-ingress" {
name = "allow-all-sg"
vpc_id = aws_vpc.swf-vpc.id
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
    // Terraform removes the default rule
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
    Name = "swf-jumpbox",
    namespace = "software-factory",
    component-name = "swf-jumpbox",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// EC2 
resource "aws_instance" "swf-jumpbox" {
  ami = data.aws_ami.swf-jumpbox-image.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.iac-ci-key.key_name
  security_groups = [aws_security_group.swf-ingress.id]
  tags = {
    Name = "Software Factory Jumpbox",
    namespace = "software-factory",
    component-name = "swf-jumpbox",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
  subnet_id = aws_subnet.swf-subnet.id
}

// Elastic IP
resource "aws_eip" "swf-eip" {
  instance = aws_instance.swf-jumpbox.id
  vpc      = true
  tags = {
    Name = "swf-eip",
    namespace = "software-factory",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "swf-gw" {
  vpc_id = aws_vpc.swf-vpc.id
  tags = {
    Name = "swf-gw",
    namespace = "software-factory",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// Route table
resource "aws_route_table" "route-table-swf-vpc" {
  vpc_id = aws_vpc.swf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swf-gw.id
  }
  tags = {
    Name = "route-table-swf-vpc"
    namespace = "software-factory",
    Project = "Software Factory",
    Owner = "wdrew@governmentcio.com",
    Charge_Code = "TBD",
    Environment = "Dev"
  }
}

// Route table association
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.swf-subnet.id
  route_table_id = aws_route_table.route-table-swf-vpc.id
}
