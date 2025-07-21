resource "aws_default_vpc" "myApp" {

  # tags = {
  #   Name = "myApp"
  # }
}


# Declare the data source 172.31.0.0/16 pcx-00123ce19df5fd5f7
data "aws_availability_zones" "myApp" {
  state = "available"
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.myApp.names[0]

  # tags = {
  #   Name = "Default subnet for eu-west-2a"
  # }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.myApp.names[1]

  # tags = {
  #   Name = "Default subnet for eu-west-2b"
  # }
}

resource "aws_security_group" "myApp" {
  name        = "myAppSG"
  description = "Allow access on ports 0 to 60000"
  vpc_id      = aws_default_vpc.myApp.id

  ingress {
    description = "allow traffic from ports range from 0 to 60000"
    from_port   = 0
    to_port     = 60000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# RSA key of size 4096 bits
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pk" {
  key_name   = "myKey"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "pk" {
  content  = tls_private_key.pk.private_key_pem
  filename = "${aws_key_pair.pk.key_name}.pem"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  # filter {
  #   name   = "name"
  #   values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  # }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myAppTwo" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_default_subnet.default_az1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.myApp.id]
  key_name                    = aws_key_pair.pk.key_name
  user_data                   = local.app_user_data
  #user_data_replace_on_change = true

  tags = {
    Name = "myAppTwo"
  }
}

resource "aws_instance" "myAppone" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_default_subnet.default_az1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.myApp.id]
  key_name                    = aws_key_pair.pk.key_name
  #user_data                   = local.app_user_data
  #user_data_replace_on_change = true

  tags = {
    Name = "myAppone"
  }
}

# resource "aws_instance" "myAppthree" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_default_subnet.default_az1.id
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.myApp.id]
#   key_name                    = aws_key_pair.pk.key_name

#   tags = {
#     Name = "myAppthree"
#   }
# }

# resource "aws_instance" "myAppfour" {
#   ami                         = data.aws_ami.ubuntu.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_default_subnet.default_az1.id
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.myApp.id]
#   key_name                    = aws_key_pair.pk.key_name

#   tags = {
#     Name = "myAppfour"
#   }
# }


