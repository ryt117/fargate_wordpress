output "cloudfront_dns" {
  value = aws_cloudfront_distribution.test_cf.domain_name
}