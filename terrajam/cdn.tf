resource "aws_cloudfront_distribution" "jam_cdn" {
  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2"

  origin {
    origin_id   = "any_cdn"
    domain_name = "${aws_s3_bucket.jam_bucket.bucket}.s3.af-south-1.amazonaws.com"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.jam_access_id.cloudfront_access_identity_path
    }
  }
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "any_cdn"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }
  custom_error_response {
    error_code         = "404"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

}

resource "aws_cloudfront_origin_access_identity" "jam_access_id" {
  comment = "access-id-jam-cdn"
}
