resource "aws_ecs_cluster" "test-cluster" {
  name = "test-cluster"
}

data "template_file" "testapp" {
  template = file("./template.json")

  vars = {
    app_image      = var.test_image
    app_port       = var.app_port
    fargate_cpu    = var.far_cpu
    fargate_memory = var.far_mem
    aws_region     = var.aws_reg
  }
}

resource "aws_ecs_task_definition" "test-def" {
  family                   = "test-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.far_cpu
  memory                   = var.far_mem
  container_definitions    = data.template_file.testapp.rendered
}

resource "aws_ecs_service" "test-service" {
  name            = "testapp-service"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.test-def.arn
  desired_count   = var.app_ct
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    container_name   = "testapp"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.testapp, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
