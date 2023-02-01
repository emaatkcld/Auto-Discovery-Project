#Create Jenkins Server
resource "aws_instance" "Jenkins-Slaves" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_id]
  subnet_id                   = var.prvsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "${var.Jenkins-Slaves}${count.index}"
  }

} 