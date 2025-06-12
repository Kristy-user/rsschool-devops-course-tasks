# Terraform AWS Infrastructure for GitHub Actions

This repository contains Terraform configuration to provision AWS infrastructure and a GitHub Actions workflow to automate provisioning.

---

## Terraform Resources

### 1. OpenID Connect Provider
- **Resource Type**: `aws_iam_openid_connect_provider`
- **Name**: `github_actions`
- **Used for**: Allowing GitHub Actions to authenticate using AWS OIDC.

### 2. S3 Bucket for Terraform State
- **Resource Type**: `aws_s3_bucket`
- **Name**: `rs-devops-2025q2-terraform-state`
- **Region**: `us-east-1`
- **Features**:
    - Versioning enabled
    - `prevent_destroy` lifecycle protection

### 3. DynamoDB Table for State Locking
- **Resource Type**: `aws_dynamodb_table`
- **Name**: `terraform-locks`
- **Used for**: Terraform state locking to prevent concurrent runs.

### 4. IAM Role for GitHub Actions
- **Resource Type**: `aws_iam_role`
- **Name**: `GithubActionsRole`
- **Trust Policy**:
    - Grants `sts:AssumeRoleWithWebIdentity` to:
        - `repo:Kristy-user/rsschool-devops-course-tasks:ref:refs/heads/main`
        - Pull requests
- **Attached Policies**:
    - `AmazonEC2FullAccess`
    - `AmazonRoute53FullAccess`
    - `AmazonS3FullAccess`
    - `IAMFullAccess`
    - `AmazonVPCFullAccess`
    - `AmazonSQSFullAccess`
    - `AmazonEventBridgeFullAccess`

---

## ⚙️ GitHub Actions Workflow

Located at `.github/workflows/terraform.yml`, the workflow is triggered on `push` and `pull_request` events for the `main` branch.

### Jobs:
- ✅ **terraform-check** — Lints Terraform code using `terraform fmt`
- 📋 **terraform-plan** — Runs `terraform plan` using the IAM role
- 🚀 **terraform-apply** — Applies the infrastructure changes on merge to main

### Example OIDC Setup:
```yaml
- name: Configure AWS credentials (OIDC)
  uses: aws-actions/configure-aws-credentials@v2
  with:
    role-to-assume: arn:aws:iam::${{ env.AWS_ACCOUNT_ID }}:role/GithubActionsRole
    aws-region: us-east-1
```
---

## 💻 Usage Locally

1. **Clone the Repository**:
    git clone https://github.com/Kristy-user/rsschool-devops-course-tasks.git
    cd rsschool-devops-course-tasks

2. **Initialize Terraform**:
    terraform init

3. **Check Plan**:
    terraform plan

4. **Apply Infrastructure**:
    terraform apply

