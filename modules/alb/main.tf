

#Create Target Group for Load Balancer
resource "aws_lb_target_group" "padeu2-tg" {
  name     = "padeu2-tg"
  port     = var.tg-port
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 60
    timeout             = 5
  }
}

#Creat Target Group Attachment
resource "aws_lb_target_group_attachment" "padeu2-tg-attch" {
  target_group_arn = aws_lb_target_group.padeu2-tg.arn
  target_id        = var.docker-host
  port             = var.tg-port
}


# Creating the Application Load Balancer
resource "aws_lb" "padeu2-lb" {
  name                       = "padeu2-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb-sg]
  subnets                    = [var.prvsn1, var.prvsn2]
  enable_deletion_protection = false

  tags = {
    name = "padeu2-lb"
  }

}


# Create Load Balancer Listener for Docker
resource "aws_lb_listener" "padeu22_lb_listener" {
  load_balancer_arn = aws_lb.padeu2-lb.arn
  port     = var.tg-port
  protocol = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.padeu2-tg.arn
  }
}
