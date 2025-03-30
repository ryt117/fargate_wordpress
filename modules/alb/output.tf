output "alb_tg" {
  value = aws_lb_target_group.test.arn
}
output "alb_dns" {
  value = aws_lb.alb.dns_name
}