output "jenkins_privateip" {
    value = aws_instance.Jenkins-Server.private_ip
  
}

output "jenkins_id" {
    value = aws_instance.Jenkins-Server.id
  
}