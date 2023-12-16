resource "aws_cloudfront_distribution" "website" {
  #checkov:skip=CKV2_AWS_32: "Ensure CloudFront distribution has a response headers policy attached"
  #checkov:skip=CKV2_AWS_47: "Ensure AWS CloudFront attached WAFv2 WebACL is configured with AMR for Log4j Vulnerability"
  #checkov:skip=CKV2_AWS_42: "Ensure AWS CgloudFront distribution uses custom SSL certificate"
  #checkov:skip=CKV_AWS_310: "Ensure CloudFront distributions should have origin failover configured"
  #checkov:skip=CKV_AWS_68: "CloudFront Distribution should have WAF enabled"
  #checkov:skip=CKV_AWS_86: "Ensure Cloudfront distribution has Access Logging enabled"
  #checkov:skip=CKV_AWS_174: "Verify CloudFront Distribution Viewer Certificate is using TLS v1.2"

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  //aliases = [var.route53.host_name]

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website.bucket

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.website.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["HU"] #["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 404
    response_page_path    = "/error.html"
  }


}

resource "aws_cloudfront_origin_access_identity" "website" {
  comment = "Allows CloudFront to reach to S3"
}


