data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["679593333241"]
}
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name = "centos_aws_ssh"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_security_group" "allow_ssh" {
name = "allow_ssh"
description = "Security group for server HelloWorld"
ingress { 
from_port = 22 
to_port = 22 
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
}

egress { 
from_port = 0 
to_port = 0 
protocol = "-1" 
cidr_blocks = ["0.0.0.0/0"] 
 } 
}