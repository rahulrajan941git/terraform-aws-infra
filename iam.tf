# --- IAM USERS ---
resource "aws_iam_user" "IAMUser" {
  path = "/"
  name = "former2"
  tags = {
    former = "true"
  }
}

resource "aws_iam_user" "IAMUser2" {
  path = "/"
  name = "Rahul"
  tags = {
    CLI_Rahul = "true"
  }
}

# --- IAM ROLES ---
resource "aws_iam_role" "IAMRole" {
  path = "/"
  name = "aws-elasticbeanstalk-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role" "IAMRole3" {
  path = "/"
  name = "ec2-ssm-full-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role" "IAMRole4" {
  path = "/"
  name = "instanceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# --- IAM INSTANCE PROFILES ---
resource "aws_iam_instance_profile" "IAMInstanceProfile2" {
  path = "/"
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.IAMRole3.name
}

resource "aws_iam_instance_profile" "IAMInstanceProfile3" {
  path = "/"
  name = aws_iam_role.IAMRole4.name
  role = aws_iam_role.IAMRole4.name
}

resource "aws_iam_role_policy_attachment" "ssm_full_access" {
  role       = aws_iam_role.IAMRole3.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}