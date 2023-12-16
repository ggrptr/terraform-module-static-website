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

resource "aws_s3_object" "document" {
  for_each     = fileset("${path.module}/documents", "*")
  bucket       = module.example.bucket_name
  key          = each.value
  source       = "./documents/${each.value}"
  content_type = "text/html"
}

output "example" {
  value = module.example.*
}

output "test_url" {
  value = "https://${module.example.cloudfront_domain_name}"
}