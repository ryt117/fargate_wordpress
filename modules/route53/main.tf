resource "aws_route53_zone" "test_zone" {
  name = "example.com"
}

resource "aws_route53_record" "test_record" {
  zone_id = aws_route53_zone.test_zone.id
  name    = "example.com"
  type    = "A"
  alias {
    name                   = var.cloudfront_dns
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}