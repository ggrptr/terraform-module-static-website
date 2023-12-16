module "label_module" {
  source  = "git::https://github.com/cloudposse/terraform-null-label?ref=488ab91e34a24a86957e397d9f7262ec5925586a"
  context = var.context
}

module "label_aws_s3_bucket_website" {
  source  = "git::https://github.com/cloudposse/terraform-null-label?ref=488ab91e34a24a86957e397d9f7262ec5925586a"
  context = module.label_module.context
}
