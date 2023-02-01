output "ansible-sg-id" {
  value = aws_security_group.PADEU2_Ansible_SG.id
}

output "docker-sg-id" {
  value = aws_security_group.PADEU2_Docker_SG.id
}

output "jenkins-sg-id" {
  value = aws_security_group.PADEU2_Jenkins_SG.id
}

output "sonarqube-sg-id" {
  value = aws_security_group.PADEU2_Sonarqube_SG.id
}

output "mysql-sg-id" {
  value = aws_security_group.PADEU2_DB_Backend_SG.id
}

output "alb-sg-id" {
  value = aws_security_group.PADEU2_ALB_SG.id
}

output "bastion-sg-id" {
  value = aws_security_group.PADEU2_bastion_SG.id
}

