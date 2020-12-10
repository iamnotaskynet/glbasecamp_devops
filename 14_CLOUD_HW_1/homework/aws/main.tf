provider "aws" {
    region = "us-west-2"
}

# INSTANCE 1
resource "aws_instance" "ubu1" {
    ami                     = "ami-07dd19a7900a1f049"
    availability_zone       = "us-west-2a"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [ aws_security_group.sg1.id ]
    user_data = file("ubu1nginx.bash")
    tags = {    Name = "ubu1"   }
}

# INSTANCE 1 Security Group
resource "aws_security_group" "sg1" {
    name = "SecGroup 1"

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
    user_data               = file("ubu2nginx.bash")
    tags                    = { Name = "ubu2" }
}

# INSTANCE 2 Security Group
resource "aws_security_group" "sg2" {
    name = "SecGroup 2"

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
resource "aws_elb" "loadbalancer" {
  name               = "loadbalancer-terraform-elb"
  availability_zones = [ "us-west-2a", "us-west-2b" ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.ubu1.id, aws_instance.ubu2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = { Name = "Homework-terraform-elb" }
}

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

output "aws_elb_dns_name" {
  value = aws_elb.loadbalancer.dns_name
}