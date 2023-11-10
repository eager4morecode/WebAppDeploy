provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index + 1}.0/24"
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  // Define inbound/outbound rules...
}

resource "aws_db_instance" "main" {
  // Define RDS configuration...
}

resource "aws_lb" "main" {
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web_sg.id]
  subnets = aws_subnet.public[*].id
}

resource "aws_autoscaling_group" "main" {
  // Define Auto Scaling Group configuration...
}

