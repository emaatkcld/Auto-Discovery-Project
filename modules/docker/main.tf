#Create Docker Host
resource "aws_instance" "PADEU2-Docker-Host-Server" {
  ami                    = var.docker-ami
  instance_type          = var.inst-type
  vpc_security_group_ids = [var.docker-sg]
  subnet_id              = var.prvsubnet
  key_name               = var.kp
  user_data              = <<-EOF
#!/bin/bash
sudo yum install -y yum-utils
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
#Start docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
#Install New relic
echo "license_key: eu01xxbca018499adedd74cacda9d3d13e7dNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo 
https://downloads.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
EOF
  tags = {
    Name = "Docker_Host"
  }
}

