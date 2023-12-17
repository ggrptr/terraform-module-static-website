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
  default_root_object = var.distribution_properties.index_document

  aliases = var.distribution_properties.domain_aliases

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
      restriction_type = var.distribution_properties.geo_restriction.restriction_type
      locations        = var.distribution_properties.geo_restriction.locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  dynamic "custom_error_response" {
    for_each = var.distribution_properties.custom_error_responses
    content {
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "website" {
  comment = "Allows CloudFront to reach to S3"
}


