# ECSクラスタ
resource "aws_ecs_cluster" "this" {
  name = "wordpress"
}

# タスク定義
resource "aws_ecs_task_definition" "wordpress" {
  family = "wordpress-difinition"
  requires_compatibilities = ["FARGATE"]
  cpu = "1024"
  memory = "2048"
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::hogehoge:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name = "wordpress"
      image = "hogehoge.dkr.ecr.ap-northeast-1.amazonaws.com/wordpress:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostport      = 80
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name =  "WORDPRESS_DB_HOST"
          value = var.db_host
        },
        {
          name = "WORDPRESS_DB_NAME"
          value = var.db_name
        },
        {
          name =  "WORDPRESS_DB_USER"
          value = var.db_user
        },
        {
          name = "WORDPRESS_DB_PASSWORD"
          value = var.db_password
        }
      ]
    }
  ])
}

# ECSサービス
resource "aws_ecs_service" "wordpress" {
  name = "wordpress-service"
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = [var.public_subnet1_id, var.public_subnet2_id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_tg
    container_name = "wordpress"
    container_port = 80
  }
}

#SG
resource "aws_security_group" "ecs_sg" {
  name = "ecs-sg"
  description = "Allow HTTP"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}