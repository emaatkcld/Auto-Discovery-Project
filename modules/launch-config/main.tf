# Create AMI from Docker Host
resource "aws_ami_from_instance" "padeu2-docker-ami" {
  name                    = "padeu2-docker-ami"
  source_instance_id      = var.source-instance-id
  snapshot_without_reboot = true
}

#Lunch Configuration Template
resource "aws_launch_configuration" "padeu2_lc" {
  name                        = "padeu2-lc"
  image_id                    = aws_ami_from_instance.padeu2-docker-ami.id
  instance_type               = var.inst-type
  key_name                    = var.inst-kp
  security_groups             = [var.lc-sg]
  associate_public_ip_address = true
  user_data                   = <<-EOF
  #!/bin/bash
  sudo docker restart pet-adoption-container
  EOF

  depends_on = [
    var.lc-sg
  ]
}
