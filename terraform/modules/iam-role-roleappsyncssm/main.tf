# RoleAppSyncSSM
resource "aws_iam_role" "RoleAppSyncSSM" {
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
