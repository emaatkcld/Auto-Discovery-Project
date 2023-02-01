#Create Bastion Server
resource "aws_instance" "Bastion-Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.security_id]
  subnet_id                   = var.pubsubnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  provisioner "file" {
    source      = "~/key-pair/padeu2-kp"
    destination = "/home/ec2-user/padeu2-kp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname Bastion",
      "sudo chmod 400 /home/ec2-user/padeu2-kp"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/key-pair/padeu2-kp")
    host        = self.public_ip
  }
  tags = {
    Name = var.Bastion_Host_Name
  }
}