#fetches latest Ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "t2micro" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.instance_key.key_name
  instance_type          = "t2.micro"
  availability_zone      = "sa-east-1c"
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  count                  = var.instance_num

  tags = {
    Name = "instance-${count.index + 1}"
  }
}