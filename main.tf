# # Create a new instance of the latest Ubuntu 20.04 on an
# # t3.micro node with an AWS Tag naming it "HelloWorld"

# provider "aws" {
#   profile = "default"
#   region  = var.region
# }


# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_instance" "honeypot-ec2" {
#   # name                        = "honeypot-ec2"
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = "t3.micro"
#   key_name                    = var.ssh_key_pair
#   associate_public_ip_address = true
#   # vpc_security_group_ids      = [aws_security_group.honeypot-sg.id]
#   # subnet_id                   = aws_subnet.subnet.id

#   tags = {
#     Name = var.tag
#   }
# }

# # resource "aws_eip" "ubuntu" {
# #   vpc      = true
# #   instance = aws_instance.honeypot-ec2.id
# # }
# # resource "aws_subnet" "subnet" {
# #   vpc_id            = aws_vpc.vpc.id
# #   # availability_zone = element(data.aws_availability_zones.azs.names, 1)
# #   cidr_block        = "10.0.2.0/24"
# # }


# # #Create VPC in us-east-1
# # resource "aws_vpc" "vpc" {
# #   cidr_block           = "10.0.0.0/16"
# #   enable_dns_support   = true
# #   enable_dns_hostnames = true
# #   tags = {
# #     Name = var.tag
# #   }
# # }

# resource "aws_security_group" "honeypot-sg" {
#   name        = "honeypot-sg"
#   description = "Allow TCP/8080 & TCP/22"
#   # vpc_id      = aws_vpc.vpc.id
#   ingress {
#     description = "Allow 22 from our public IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "allow anyone on port 8080"
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "allow traffic from us-west-2"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["192.168.1.0/24"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



#

# resource "aws_subnet" "tf_test_subnet" {
#   vpc_id                  = "vpc-09304116708eea386" 
#   cidr_block              = "10.0.0.0/24"
#   map_public_ip_on_launch = true

#   depends_on = [aws_internet_gateway.gw]
# }

resource "aws_instance" "foo" {
  # us-west-2
  key_name      = "towelie-ubuntu"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # private_ip = "10.0.0.12"
  subnet_id  = "subnet-0c8480b317fab1b3d"
}


resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    =  "sg-0ca6651adeb1e4f67"
  network_interface_id = "${aws_instance.foo.primary_network_interface_id}"
}

resource "aws_eip" "bar" {
  vpc = true
  instance                  = aws_instance.foo.id
  # associate_with_private_ip = "10.0.0.12"
  # depends_on                = [aws_internet_gateway.gw]
}

# resource "aws_key_pair" "master-key" {
#   key_name   = "towelie-ubuntu"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }


# resource "aws_security_group" "ubuntu" {
#   name        = "ubuntu-security-group"
#   description = "Allow HTTP, HTTPS and SSH traffic"
# }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "terraform"
#   }
# }


# resource "aws_instance" "ubuntu" {
#   key_name      = "towelie-ubuntu"
#   ami           = data.aws_ami.ubuntu.id
#   vpc_security_group_ids = [aws_security_group.ubuntu.id]
#   instance_type = "t2.micro"
#   associate_public_ip_address = true
#   tags = {
#     Name = "ubuntu"
#   }


# resource "aws" "aws_instance" {

# }

# #   vpc_security_group_ids = [
# #     aws_security_group.ubuntu.id
# #   ]

# #   ebs_block_device {
# #     device_name = "/dev/sda1"
# #     volume_type = "gp2"
# #     volume_size = 30
# #   }
# }

# # resource "aws_internet_gateway" "gw" {
# #   vpc_id = ubuntu.id

# #   tags = {
# #     Name = "main"
# #   }
# # }