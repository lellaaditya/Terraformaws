provider "aws" {
  region = "us-west-2"  # Change this to your desired AWS region
}

# Define managed policy ARNs
variable "managed_policy_arns" {
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]
}

# Define IAM roles
variable "roles" {
  default = [
    {
      name                 = "role1"
      managed_policy_arns = [var.managed_policy_arns[0]]  # Attach first managed policy
    },
    {
      name = "role2"
      # No managed policies attached
    },
    {
      name                 = "role3"
      managed_policy_arns = [var.managed_policy_arns[1]]  # Attach second managed policy
    }
  ]
}

# Create IAM roles
resource "aws_iam_role" "roles" {
  count = length(var.roles)

  name               = var.roles[count.index].name
  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Effect"    : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action"    : "sts:AssumeRole"
    }]
  })

  # Attach managed policies if provided
  dynamic "policy" {
    for_each = var.roles[count.index].managed_policy_arns != null ? var.roles[count.index].managed_policy_arns : []
    content {
      arn = policy.value
    }
  }
}

output "role_names" {
  value = aws_iam_role.roles[*].name
}provider "aws" {
  region = "us-west-2"  # Change this to your desired AWS region
}

# Define managed policy ARNs
variable "managed_policy_arns" {
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]
}

# Define IAM roles
variable "roles" {
  default = [
    {
      name                 = "role1"
      managed_policy_arns = [var.managed_policy_arns[0]]  # Attach first managed policy
    },
    {
      name = "role2"
      # No managed policies attached
    },
    {
      name                 = "role3"
      managed_policy_arns = [var.managed_policy_arns[1]]  # Attach second managed policy
    }
  ]
}

# Create IAM roles
resource "aws_iam_role" "roles" {
  count = length(var.roles)

  name               = var.roles[count.index].name
  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [{
      "Effect"    : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action"    : "sts:AssumeRole"
    }]
  })

  # Attach managed policies if provided
  dynamic "policy" {
    for_each = var.roles[count.index].managed_policy_arns != null ? var.roles[count.index].managed_policy_arns : []
    content {
      arn = policy.value
    }
  }
}

output "role_names" {
  value = aws_iam_role.roles[*].name
}
