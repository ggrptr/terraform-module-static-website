variables {
  context = {
    namespace = "test-"
  }
}

run "bucket prefix" {
  command = apply

  assert {
    condition     = substr(aws_s3_bucket.example.bucket, 0, length(var.context.namespace)) == var.context.namespace
    error_message = "S3 bucket name did not match expected"
  }
}