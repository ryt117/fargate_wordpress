resource "aws_lb" "alb" {
  name               = "MyLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]
  enable_deletion_protection = false
} 

resource "aws_lb_target_group" "test" {
  name = "test-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/wp-admin/install.php"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:ap-northeast-1:061039782769:certificate/b7f2c39b-71e8-4bb3-8595-8a0cfe3738da" #ALBの証明書
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"
      redirect {
      protocol = "HTTPS"
      port     = "443"
      status_code = "HTTP_301"    
      }
  }
}

resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  description = "Allow HTTP and SSH"
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}