output "jenkins_privateip" {
    value = aws_instance.Jenkins-Slaves.*.private_ip
  
}
