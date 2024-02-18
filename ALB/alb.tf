resource "aws_lb" "alb" {
  name               = "ALB"
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = [var.public_subnet1, var.public_subnet2]
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.autoscaling_group_name
  lb_target_group_arn   = aws_lb_target_group.lb_target_group.arn
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


  health_check {
    path                = "/health"
    port                = 80
    protocol            = "HTTP"
    interval            = 30 # Seconds between health checks
    timeout             = 5  # Seconds to wait for a response
    healthy_threshold   = 2  # Number of consecutive successes required for a target to be considered healthy
    unhealthy_threshold = 2  # Number of consecutive failures required for a target to be considered unhealthy
  }
  depends_on = [aws_lb.alb]
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}