# Create an ALB
resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.subnet1[*].id
  enable_deletion_protection = false  # Optional: Enable or disable deletion protection
}

# Create an ALB Target Group
resource "aws_lb_target_group" "example" {
  name     = "example-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id
  deregistration_delay  = var.deregistration_delay
}

# Create an ALB Listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}

# Create an ALB Listener Rule to Forward to ASG
resource "aws_lb_listener_rule" "example" {
  listener_arn = aws_lb_listener.example.arn
  priority    = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }

  condition {
    path_pattern {
      values = ["/example"]
    }
  }
}