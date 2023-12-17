# Simple page application with S3 and CloudFront

[![](https://img.shields.io/badge/github-ggrptr/terraform--module--static--website-%233DA639.svg)](https://github.com/ggrptr/terraform-module-template "github.com/ggrptr/terraform-module-static-website")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.16.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_label_aws_s3_bucket_website"></a> [label\_aws\_s3\_bucket\_website](#module\_label\_aws\_s3\_bucket\_website) | git::https://github.com/cloudposse/terraform-null-label | 488ab91e34a24a86957e397d9f7262ec5925586a |
| <a name="module_label_module"></a> [label\_module](#module\_label\_module) | git::https://github.com/cloudposse/terraform-null-label | 488ab91e34a24a86957e397d9f7262ec5925586a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_iam_policy_document.read_website_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_properties"></a> [bucket\_properties](#input\_bucket\_properties) | Object wrapper for the bucket properties. The name and prefix are mutually exclusive, if neither is specified, the bucket prefix will be generated from the context. | <pre>object({<br>    bucket_name       = optional(string, null)<br>    bucket_prefix     = optional(string, null)<br>    force_destroy     = optional(bool, false)<br>    versioning_status = optional(string, "Enabled")<br>  })</pre> | <pre>{<br>  "bucket_name": null,<br>  "bucket_prefix": null,<br>  "force_destroy": false,<br>  "versioning_status": "Enabled"<br>}</pre> | no |
| <a name="input_context"></a> [context](#input\_context) | Object wrapper for the context map of the null label module. See the null label module for more information. | <pre>object({<br>    enabled             = optional(bool, true)<br>    namespace           = optional(string, null)<br>    tenant              = optional(string, null)<br>    environment         = optional(string, null)<br>    stage               = optional(string, null)<br>    name                = optional(string, null)<br>    delimiter           = optional(string, null)<br>    attributes          = optional(list(string), [])<br>    tags                = optional(map(string), {})<br>    additional_tag_map  = optional(map(string), {})<br>    regex_replace_chars = optional(string, null)<br>    label_order         = optional(list(string), [])<br>    id_length_limit     = optional(number, null)<br>    label_key_case      = optional(string, null)<br>    label_value_case    = optional(string, null)<br>    descriptor_formats  = optional(map(string), {})<br>    labels_as_tags      = optional(list(string), ["unset"])<br>  })</pre> | n/a | yes |
| <a name="input_distribution_properties"></a> [distribution\_properties](#input\_distribution\_properties) | Object wrapper for the distribution properties. | <pre>object({<br>    index_document = optional(string, "index.html")<br>    custom_error_responses = optional(<br>      list(<br>        object({<br>          error_caching_min_ttl = number<br>          error_code            = number<br>          response_code         = number<br>          response_page_path    = string<br>        })<br>      ),<br>      [<br>        {<br>          error_caching_min_ttl = 300<br>          error_code            = 404<br>          response_code         = 404<br>          response_page_path    = "/error.html"<br>        },<br>        {<br>          error_caching_min_ttl = 300<br>          error_code            = 403<br>          response_code         = 403<br>          response_page_path    = "/error.html"<br>        }<br>    ])<br><br>    domain_aliases = optional(list(string), [])<br>    geo_restriction = optional(object({<br>      restriction_type = string<br>      locations        = list(string)<br>      }), {<br>      restriction_type = "none"<br>      locations        = []<br>    })<br><br><br>  })</pre> | <pre>{<br>  "custom_error_responses": [<br>    {<br>      "error_caching_min_ttl": 300,<br>      "error_code": 404,<br>      "response_code": 404,<br>      "response_page_path": "/error.html"<br>    }<br>  ],<br>  "domain_aliases": [],<br>  "geo_restriction": {<br>    "locations": [],<br>    "restriction_type": "none"<br>  },<br>  "index_document": "index.html"<br>}</pre> | no |
| <a name="input_website_properties"></a> [website\_properties](#input\_website\_properties) | Object wrapper for the S3 website properties. | <pre>object({<br>    index_document = optional(string, "index.html")<br>    error_document = optional(string, "error.html")<br>  })</pre> | <pre>{<br>  "error_document": "error.html",<br>  "index_document": "index.html"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
<!-- END_TF_DOCS -->

**[MIT License](LICENSE)**

Copyright (c) 2023 [ggrptr](https://github.com/ggrptr)