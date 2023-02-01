#Create AutoScaling Group
resource "aws_autoscaling_group" "padeu2-asg" {
  name                      = "padeu2-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = var.lc-name
  vpc_zone_identifier       = [var.prvsn1, var.prvsn2]
  target_group_arns         = [var.tg-arn]

}

#Create ASG Policy
resource "aws_autoscaling_policy" "padeu2-asg-policy" {
  name = "padeu2-asg-policy"
  #scaling_adjustment     = 4
  policy_type     = "TargetTrackingScaling"
  adjustment_type = "ChangeInCapacity"
  #cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.padeu2-asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}