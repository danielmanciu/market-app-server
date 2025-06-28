# Creates the assume role for EC2
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Creates a rule that EC2 instances can assume
resource "aws_iam_role" "ec2_role" {
  name               = "ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# Attach S3 Read policies to the EC2 role
resource "aws_iam_role_policy_attachment" "s3_read_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Attach ECR Pull policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ecr_pull_only_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

# Create instance profile so we can reference it in "aws_instance"
resource "aws_iam_instance_profile" "market_app_ec2_profile" {
  name = "market-app-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Project = "MarketApp"
  }
}
