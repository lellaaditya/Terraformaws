# RoleAppSyncCloudWatch
module "aws_iam_role" {
  source  = "./modules/iam-role"
  
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  ]
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "meppsync.amazonaws.com"
        }
      }
    ]
  })
}

# BasicAppSyncPolicy
module "aws_iam_policy" {
  source  = "./modules/iam-role"

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

# RoleAppSyncSSM
module "aws_iam_role" {
  source  = "./modules/iam-role"

  ssume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "meppsync.amazonaws.com"
        }
      }
    ]
  })
}
