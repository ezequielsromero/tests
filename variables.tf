variable "region" {
  description = "AWS region for the VPC"
  default     = "us-east-1"
}

variable "app_port" {
  description = "Port for your application"
  default     = 8080
}

variable "default_cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "default_instance_warmup" {
  description = "Warmup time"
  default     = 300
}

variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  default     = 300
}