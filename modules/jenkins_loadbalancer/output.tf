output "jenkins-lb" {
    value = aws_elb.jenkins-lb.dns_name
}
