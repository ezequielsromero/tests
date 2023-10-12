# Create EC2 instances from the autoscaling group
resource "aws_autoscaling_group" "example" {
  default_instance_warmup   = var.default_instance_warmup
  name                      = "example-asg"
  availability_zones        = aws_subnet.subnet1[*].availability_zone
  launch_template {
    id = aws_launch_template.example.id
  }
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  health_check_grace_period = 300
  termination_policies      = ["OldestLaunchConfiguration"]
  default_cooldown          = var.default_cooldown
  wait_for_capacity_timeout = 0
  target_group_arns         = [aws_lb_target_group.example.arn]
}

# Create an EC2 Launch Template
resource "aws_launch_template" "example" {
  name = "example-lt"
  image_id      = "ami-07d07d65c47e5aa90"
  instance_type = "t2.micro"
}


# Create Security Group for EC2 instances
resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.example.id
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

