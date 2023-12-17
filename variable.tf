variable "context" {
  type = object({
    enabled             = optional(bool, true)
    namespace           = optional(string, null)
    tenant              = optional(string, null)
    environment         = optional(string, null)
    stage               = optional(string, null)
    name                = optional(string, null)
    delimiter           = optional(string, null)
    attributes          = optional(list(string), [])
    tags                = optional(map(string), {})
    additional_tag_map  = optional(map(string), {})
    regex_replace_chars = optional(string, null)
    label_order         = optional(list(string), [])
    id_length_limit     = optional(number, null)
    label_key_case      = optional(string, null)
    label_value_case    = optional(string, null)
    descriptor_formats  = optional(map(string), {})
    labels_as_tags      = optional(list(string), ["unset"])
  })

  description = "Object wrapper for the context map of the null label module. See the null label module for more information."
}

variable "bucket_properties" {
  type = object({
    bucket_name       = optional(string, null)
    bucket_prefix     = optional(string, null)
    force_destroy     = optional(bool, false)
    versioning_status = optional(string, "Enabled")
  })
  description = "Object wrapper for the bucket properties. The name and prefix are mutually exclusive, if neither is specified, the bucket prefix will be generated from the context."

  default = {
    bucket_name       = null
    bucket_prefix     = null
    force_destroy     = false
    versioning_status = "Enabled"
  }

  validation {
    condition     = (var.bucket_properties.bucket_name == null || var.bucket_properties.bucket_prefix == null)
    error_message = "The bucket_name and bucket_prefix are mutually exclusive. Please specify only one of them."
  }

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.bucket_properties.versioning_status)
    error_message = "The versioning_status must be one of Enabled, Suspended, or Disabled."
  }
}

variable "website_properties" {
  type = object({
    index_document = optional(string, "index.html")
    error_document = optional(string, "error.html")
  })

  description = "Object wrapper for the S3 website properties."

  default = {
    index_document = "index.html"
    error_document = "error.html"
  }
}


variable "distribution_properties" {
  type = object({
    index_document = optional(string, "index.html")
    custom_error_responses = optional(
      list(
        object({
          error_caching_min_ttl = number
          error_code            = number
          response_code         = number
          response_page_path    = string
        })
      ),
      [
        {
          error_caching_min_ttl = 300
          error_code            = 404
          response_code         = 404
          response_page_path    = "/error.html"
        },
        {
          error_caching_min_ttl = 300
          error_code            = 403
          response_code         = 403
          response_page_path    = "/error.html"
        }
    ])

    domain_aliases = optional(list(string), [])
    geo_restriction = optional(object({
      restriction_type = string
      locations        = list(string)
      }), {
      restriction_type = "none"
      locations        = []
    })


  })
  description = "Object wrapper for the distribution properties."
  default = {
    index_document = "index.html"
    custom_error_responses = [{
      error_caching_min_ttl = 300
      error_code            = 404
      response_code         = 404
      response_page_path    = "/error.html"
    }]
    domain_aliases = []
    geo_restriction = {
      restriction_type = "none"
      locations        = []
    }
  }
}


