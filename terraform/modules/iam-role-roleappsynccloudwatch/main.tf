# RoleAppSyncCloudWatch
resource "aws_iam_role" "RoleAppSyncCloudWatch" {
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


tags = {
    "PH:Service:Name"        = var.service_name
    "PH:Service:Tag"         = "iam"
    "PH:Service:Environment" = var.service_environment
    "Test"                   = "Test"
  }

}
