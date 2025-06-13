variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "rs--aws-example-bucket"
}

variable "bucket_tag_name" {
  default = "test-terraform-bucket"
}

variable "dynamodb_table_name" {
  default = "terraform-locks"
}

variable "github_repository" {
  default = "Kristy-user/rsschool-devops-course-tasks"
}

variable "aws_account_id" {
  default = "477935059681"
}

variable "git_actions_policies" {
  description = "List of policies for GithubActionsRole"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
}
