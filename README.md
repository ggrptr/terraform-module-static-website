# Simple page application with S3 and CloudFront

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
| [aws_s3_bucket_website_configuration.website](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_iam_policy_document.read_website_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Object wrapper for the context map of the null label module. See the null label module for more information. | <pre>object({<br>    enabled             = optional(bool, true)<br>    namespace           = optional(string, null)<br>    tenant              = optional(string, null)<br>    environment         = optional(string, null)<br>    stage               = optional(string, null)<br>    name                = optional(string, null)<br>    delimiter           = optional(string, null)<br>    attributes          = optional(list(string), [])<br>    tags                = optional(map(string), {})<br>    additional_tag_map  = optional(map(string), {})<br>    regex_replace_chars = optional(string, null)<br>    label_order         = optional(list(string), [])<br>    id_length_limit     = optional(number, null)<br>    label_key_case      = optional(string, null)<br>    label_value_case    = optional(string, null)<br>    descriptor_formats  = optional(map(string), {})<br>    labels_as_tags      = optional(list(string), ["unset"])<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
<!-- END_TF_DOCS -->

**[MIT License](LICENSE)**

Copyright (c) 2023 [ggrptr](https://github.com/ggrptr)