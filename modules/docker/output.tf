output "Docker_privateip" {
    value = aws_instance.PADEU2-Docker-Host-Server.private_ip
  
}

output "Docker_host_id" {
    value = aws_instance.PADEU2-Docker-Host-Server.id
  
}