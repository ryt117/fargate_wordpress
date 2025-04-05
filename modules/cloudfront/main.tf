resource "aws_cloudfront_distribution" "test_cf" {
  origin {
    domain_name = var.alb_dns
    origin_id   = var.alb_dns
    custom_origin_config {
      origin_protocol_policy    = "https-only"
      https_port                = 443
      http_port                 = 80 
      origin_ssl_protocols      = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Caching Disabled
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # All Viewer
    target_origin_id = var.alb_dns
    viewer_protocol_policy = "redirect-to-https"
  }

  enabled = true

  price_class = "PriceClass_200"

  aliases = ["ryu-test.click"]
  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:061039782769:certificate/63b63c8c-7b8c-495c-93d7-ed6b5d026925" # us-east-1の証明書
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
