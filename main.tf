# EC2 instances public subnet
resource "aws_instance" "jacques1_EC2" {
  ami               = "ami-026b57f3c383c2eec"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  security_groups   = [aws_security_group.jacques_sg.id]
  subnet_id         = aws_subnet.jacques-Public1.id

  tags = {
    Name = "jacques_EC2"
  }
}

resource "aws_instance" "Awsers_EC2" {
  ami               = "ami-026b57f3c383c2eec"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1b"
  security_groups   = [aws_security_group.week18_sg.id]
  subnet_id         = aws_subnet.Public2.id

  tags = {
    Name = "Awsers_EC2"
  }
}