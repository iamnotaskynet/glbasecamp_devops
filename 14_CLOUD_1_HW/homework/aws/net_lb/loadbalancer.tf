provider "aws" {
    region = "us-west-2"
}
# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}
# Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = { Name = "gw" }
}

resource "aws_subnet" "sb1" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone       = "us-west-2a"
  cidr_block = "10.0.1.0/24"
  tags = { Name = "sb1" }
}

resource "aws_subnet" "sb2" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone       = "us-west-2b"
  cidr_block = "10.0.2.0/24"
  tags = { Name = "sb2" }
}
 
resource "aws_lb" "netlb" {
  name               = "netlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.sb1.id, aws_subnet.sb2.id]

  enable_deletion_protection = false
  tags = { Environment = "production" }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.netlb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

}

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id
  
  health_check {
    # path     = "/index.nginx-debian.html"
    port     = 80
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "tga1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ubu1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tga2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ubu2.id
  port             = 80
}

# INSTANCE 1
resource "aws_instance" "ubu1" {
    ami                     = "ami-07dd19a7900a1f049"
    availability_zone       = "us-west-2a"
    instance_type           = "t2.micro"
    subnet_id               = aws_subnet.sb1.id
    vpc_security_group_ids  = [ aws_security_group.sg1.id ]
    user_data               = file("../bash/ubu1nginx.bash")
    tags                    = { Name = "ubu1" }
}

# INSTANCE 1 Security Group
resource "aws_security_group" "sg1" {
    name = "SecGroup 1"
    vpc_id      = aws_vpc.vpc.id
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 
}

# INSTANCE 2
resource "aws_instance" "ubu2" {
    ami                     = "ami-07dd19a7900a1f049"
    availability_zone       = "us-west-2b"
    instance_type           = "t2.micro"
    subnet_id               = aws_subnet.sb2.id
    vpc_security_group_ids  = [ aws_security_group.sg2.id ]
    user_data               = file("../bash/ubu2nginx.bash")
    tags                    = { Name = "ubu2" }
}

# INSTANCE 2 Security Group
resource "aws_security_group" "sg2" {
    name = "SecGroup 2"
    vpc_id      = aws_vpc.vpc.id
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
    } 
}


# -------------------------------------------------------------------

output "aws_lb_dns_name" {
  value = aws_lb.netlb.dns_name
}