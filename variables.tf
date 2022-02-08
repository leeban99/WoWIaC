variable "aws_reg" {
  default     = "us-west-1"
}

variable "az_ct" {
  default     = "2"
}

variable "ecs_task_exec_role" {
  default     = "ecsTaskExecRole"
}

variable "test_image" {
  default     = "test:latest"
}

variable "app_port" {
  default     = "8080"
}

variable "app_ct" {
  default     = "2"
}

variable "health_check_path" {
  default = "/"
}

variable "far_cpu" {
  default     = "1024"
}

variable "far_mem" {
  default     = "2048"
}
