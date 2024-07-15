################################################################################
# S3 Policy
################################################################################
data "aws_iam_policy_document" "s3" {
  count = var.create_role && var.attach_s3_policy ? 1 : 0

  statement {
    sid = "S3importexportitems"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]
    resources = [for bucket in var.s3_bucket_arns : "${bucket}/*"]
  }

  statement {
    sid = "S3list"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]
    resources = var.s3_bucket_arns
  }
}

resource "aws_iam_policy" "s3" {
  count = var.create_role && var.attach_s3_policy ? 1 : 0

  name_prefix = "${var.policy_name_prefix}${var.app_name}-"
  path        = var.role_path
  description = "Interact with S3"
  policy      = data.aws_iam_policy_document.s3[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "s3_policy" {
  count = var.create_role && var.attach_s3_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.s3[0].arn
}
