provider "aws" {
    region = "us-west-2"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"
}

# Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = { Name = "gw" }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"
  tags = { Name = "subnet1" }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-west-2b"
  tags = { Name = "subnet2" }
}

# Network 1
resource "aws_network_interface" "network1" {
  subnet_id   = aws_subnet.subnet1.id
  private_ips = ["172.16.10.100"]
  tags = { Name = "network1" }
}

# Network 2
resource "aws_network_interface" "network2" {
  subnet_id   = aws_subnet.subnet2.id
  private_ips = ["172.16.20.200"]
  tags = { Name = "network2" }
}

# INSTANCE 1
resource "aws_instance" "ubu1" {
    ami                     = "ami-07dd19a7900a1f049"
    availability_zone       = "us-west-2a"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [ aws_security_group.sg1.id ]

    network_interface {
      network_interface_id = aws_network_interface.network1.id
      device_index         = 0
    }
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
    vpc_security_group_ids  = [ aws_security_group.sg2.id ]
    network_interface {
      network_interface_id = aws_network_interface.network2.id
      device_index         = 0
    }
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


# Load Balancer
resource "aws_lb" "loadbalancer" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  # security_groups    = [aws_security_group.sg1.id, aws_security_group.sg2.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  # enable_deletion_protection = false

  # access_logs { }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_lb_target_group" "lbtg1" {
  name     = "lbtg1"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  
  health_check {
    port     = 80
    protocol = "HTTP"
    path     = "/"
  }
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lbtg1.id
    type             = "forward"
  }
  
}

# ------------------------------------------------------------
# OUTPUT 

output "ubu1_public_ip" {
  value = aws_instance.ubu1.public_ip
}

output "ubu2_public_ip" {
  value = aws_instance.ubu2.public_ip
}

output "ubu1_availability_zone" {
  value = aws_instance.ubu1.availability_zone
}

output "ubu2_availability_zone" {
  value = aws_instance.ubu2.availability_zone
}

output "aws_lb_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}