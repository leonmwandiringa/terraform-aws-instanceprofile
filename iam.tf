data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_instance_profile" "default" {
  name  = var.instance_iam_role_name
  role  = aws_iam_role.default.name
}

resource "aws_iam_role" "default" {
  name                 = var.instance_iam_role_name
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.default.json
  tags = var.global_tags
}

data "aws_iam_policy" "AWSPolicy" {
  count = length(var.instance_profile_policies_attachment) != 0 ? length(var.instance_profile_policies_attachment) : 0
  arn = var.instance_profile_policies_attachment[count.index]
}

resource "aws_iam_role_policy_attachment" "AWSPolicyAttachment" {
  count = length(var.instance_profile_policies_attachment) != 0 ? length(var.instance_profile_policies_attachment) : 0
  role       = aws_iam_role.default.name
  policy_arn = data.aws_iam_policy.AWSPolicy[count.index].arn
}
