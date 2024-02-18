resource "aws_autoscaling_group" "ASG" {
  name                = "ASG-for-EC2"
  availability_zones = ["${var.region}a"]
  max_size            = 5
  min_size            = 1
  desired_capacity    = 3
  
  #target_group_arns   = [aws_lb_target_group.lb_target_group.arn]

  launch_template {
    id      = var.launch_template
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "ASG_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "ClouWatchAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 60

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asg_policy.arn]
}