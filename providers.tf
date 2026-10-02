terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Place these at the bottom of main.tf or providers.tf:

moved {
  from = aws_instance.ec2_vm
  to   = aws_instance.EC2Instance
}

moved {
  from = aws_iam_role.ssm_role
  to   = aws_iam_role.IAMRole3
}

moved {
  from = aws_iam_instance_profile.ssm_instance_profile
  to   = aws_iam_instance_profile.IAMInstanceProfile2
}

moved {
  from = aws_security_group.ssh_access
  to   = aws_security_group.EC2SecurityGroup
}