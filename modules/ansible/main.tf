resource "aws_instance" "ansible-server" {
  ami                         = var.ansible-ami
  instance_type               = var.inst-type
  key_name                    = var.kp
  vpc_security_group_ids      = [var.ansible-sg]
  subnet_id                   = var.prvsubnet
  associate_public_ip_address = true
  iam_instance_profile        = var.iam-profile
  user_data                   = <<-EOF
#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo dnf install python3 -y
sudo yum install python3-pip -y
sudo pip3 install boto boto3 botocore
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum install ansible -y
sudo chown ec2-user:ec2-user /etc/ansible/hosts
sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible
sudo hostnamectl set-hostname ansible
sudo chmod 777 /etc/ansible/hosts
sudo su echo "ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo echo "[QA-server]" >> /etc/ansible/hosts
sudo echo "${var.QA_pubip} ansible_ssh_private_key_file=/home/ec2-user/padeu2-kp" >> /etc/ansible/hosts
sudo echo "[docker_host]" >> /etc/ansible/hosts
sudo echo "${var.docker_priv_ip} ansible_ssh_private_key_file=/home/ec2-user/padeu2-kp" >> /etc/ansible/hosts


EOF
}

# pip3 install ansible --user
# sudo systemctl status sshd
# sudo yum install epel-release
# sudo sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
#sudo su - ec2-user -c 'sshpass -p "admin123" ssh-copy-id -i /home/ec2-user/.ssh/ansible-key ec2-user@${var.docker_priv_ip} -p 22'
#sudo ssh-copy-id -i /home/ec2-user/.ssh/ansible-key ec2-user@localhost -p 22
#/etc/ansible
#sudo su - ec2-user -c "ssh-keygen -f ~/.ssh/ansible-key -t rsa -N ''"
# sudo su -c 'echo admin123 | passwd ec2-user --stdin
# sudo mkdir /etc/ansible
# sudo touch /etc/ansible/hosts
# sudo chown ec2-user:ec2-user /etc/ansible/hosts
# sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible
# sudo hostnamectl set-hostname ansible
# sudo chmod 777 /etc/ansible/hosts
# ansible --version
