provider "aws" {
  region = "eu-central-1"
}

module "example" {
  source = "./.."

  context = {
    namespace   = "spa"
    environment = "demo"
    tags = {
      "created_by"  = "terraform"
      "application" = "example"
    }
  }





  bucket_properties = {
    versioning_status = "Disabled"
  }

  website_properties = {
    index_document = "index.html"
    error_document = "error.html"
  }

  distribution_properties = {
    geo_restriction = {
      restriction_type = "whitelist"
      locations        = ["DE", "AT", "CH", "HU"]
    }


    custom_error_responses = [
      //NOT found
      {
        error_caching_min_ttl = 300
        error_code            = 404
        response_code         = 404
        response_page_path    = "/error.html"
      },

      //Forbidden - If the request denied by geo restriction, this will be the response
      {
        error_caching_min_ttl = 300
        error_code            = 403
        response_code         = 403
        response_page_path    = "/error.html"
    }]
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