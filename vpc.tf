# create a vpc
/* module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "web-test"
  cidr = "10.11.0.0/16"

  azs             = ["us-east-1"]
  private_subnets = ["10.11.1.0/24"]
  public_subnets  = ["10.11.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name = "Jacques"
    Environment = "Prod"
  }
} */
resource "aws_vpc" "jacques-web-test" {
  cidr_block       = "10.11.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jacques-web-test"
  }
}

#Public subnet1 and 2
resource "aws_subnet" "jacques-Public1" {
  vpc_id     = aws_vpc.jacques-web-test.id
  cidr_block = "10.11.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true 

  tags = {
    Name = "jacques-Public1"
  }
}

resource "aws_subnet" "jacques-Public2" {
  vpc_id     = aws_vpc.jacques-web-test.id
  cidr_block = "10.11.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true 

 tags = {
    Name = "jacques-Public2"
  }
}

# Private subnet 1 and 2
resource "aws_subnet" "jacques-Private1" {
  vpc_id     = aws_vpc.jacques-web-test.id
  cidr_block = "10.11.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false 

  tags = {
    Name = "jacques-Private1"
  }
}

resource "aws_subnet" "jacques-Private1" {
  vpc_id     = aws_vpc.jacques-web-test.id
  cidr_block = "10.11.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false 

  tags = {
    Name = "jacques-Private2"
  }
}

# Route table
resource "aws_route_table" "jacques_rt" {
  vpc_id = aws_vpc.jacques-web-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jacques_igw.id
  }
  
   tags = {
    Name = "jacquesRT"
  }
}

# Internet gateway
resource "aws_internet_gateway" "jacques_igw" {
  vpc_id = aws_vpc. jacques-web-tes.id

  tags = {
    Name = "jacques_igw"
  }
}

# Route table associations
resource "aws_route_table_association" "Pub_1_Association" {
  subnet_id      = aws_subnet.jacques-Public1.id
  route_table_id = aws_route_table.jacques_rt.id
}

resource "aws_route_table_association" "Pub_2_Association" {
  subnet_id      = aws_subnet.jacques-Public2.id
  route_table_id = aws_route_table.jacques_rt.id
}

# VPC security group
resource "aws_security_group" "jacques_sg" {
  name        = "jacques_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.jacques-web-test.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
   ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

# Load balancer
resource "aws_lb" "jacques_LB" {
  name               = "jacques-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jacques_sg.id]
  subnets            = [aws_subnet.jacques-Public1.id, aws_subnet.jacques-Public2.id]
 
 }

