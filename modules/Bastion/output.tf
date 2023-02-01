output "bastion_publicip" {
    value = aws_instance.Bastion-Server.public_ip
  
}