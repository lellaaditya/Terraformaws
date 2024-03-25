# BasicAppSyncPolicy
resource "aws_iam_policy" "BasicAppSyncPolicy" {
  name        = "BasicAppSyncPolicy"
  description = "Allows AppSync to access SSM parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = [
          "arn:aws:ssm:${var.region}:${var.account_id}:parameter/${var.service_name}/${var.service_environment}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "BasicAppSyncPolicyAttachment" {
  name        = "BasicAppSyncPolicy"
  policy_arn = aws_iam_policy.BasicAppSyncPolicy.arn
  roles      = [aws_iam_role.RoleAppSyncSSM.name]
}
