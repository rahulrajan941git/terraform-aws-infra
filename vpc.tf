# --- VPC & NETWORKING ---
resource "aws_vpc" "EC2VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "UAT-APP-vpc"
  }
}

resource "aws_subnet" "EC2Subnet" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/20"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet2" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.16.0/20"
  vpc_id                  = aws_vpc.EC2VPC.id
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "EC2InternetGateway" {
  vpc_id = aws_vpc.EC2VPC.id
  tags = {
    Name = "UAT-APP-igw"
  }
}

resource "aws_route_table" "EC2RouteTable2" {
  vpc_id = aws_vpc.EC2VPC.id
  tags = {
    Name = "UAT-APP-rtb-public"
  }
}

resource "aws_route" "EC2Route2" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.EC2InternetGateway.id
  route_table_id         = aws_route_table.EC2RouteTable2.id
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint" {
  vpc_endpoint_type   = "Gateway"
  vpc_id              = aws_vpc.EC2VPC.id
  service_name        = "com.amazonaws.us-east-1.s3"
  route_table_ids     = [aws_route_table.EC2RouteTable2.id]
  private_dns_enabled = false
}

# --- SECURITY GROUPS ---
resource "aws_security_group" "EC2SecurityGroup" {
  description = "Allow inbound SSH traffic from anywhere"
  name        = "allow-ssh-all"
  vpc_id      = aws_vpc.EC2VPC.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from anywhere"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    Name = "allow-ssh-sg"
  }
}