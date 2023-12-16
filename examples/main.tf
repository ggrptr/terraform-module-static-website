module "example" {
  source = "./.."

  context = {
    namespace   = "spa"
    environment = "demo"
    tags = {
      "application" = "example"
      "created_by"  = "terraform"
    }
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = module.example.bucket_name
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

output "example" {
  value = module.example.*
}

output "test_url" {
  value = "https://${module.example.cloudfront_domain_name}"
}