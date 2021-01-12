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