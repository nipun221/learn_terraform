#!/usr/bin/env bash
set -euo pipefail

INFO="[INFO]"
WARN="[WARN]"
ERR="[ERROR]"

echo "$INFO Terraform destroy helper"

# 1. Check terraform is installed
if ! command -v terraform >/dev/null 2>&1; then
  echo "$ERR terraform is not installed or not in PATH."
  echo "     Install it from: https://developer.hashicorp.com/terraform/downloads"
  exit 1
fi

# 2. Confirm directory has Terraform files
if ! ls ./*.tf >/dev/null 2>&1; then
  echo "$ERR No .tf files found in this directory. Are you in the right project?"
  exit 1
fi

# 3. Ask for confirmation
echo
echo "$WARN This will destroy all Terraform-managed resources in this workspace."
read -r -p "Are you sure you want to continue? (yes/[no]): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "$INFO Destroy cancelled."
  exit 0
fi

# 4. Optional: show plan before destroy
echo
echo "$INFO Showing destroy plan..."
terraform plan -destroy || {
  echo "$ERR terraform plan -destroy failed. Fix issues and try again."
  exit 1
}

echo
read -r -p "Apply this destroy plan? (yes/[no]): " APPLY_CONFIRM

if [[ "$APPLY_CONFIRM" != "yes" ]]; then
  echo "$INFO Destroy aborted."
  exit 0
fi

# 5. Run terraform destroy
echo
echo "$INFO Running terraform destroy..."
terraform destroy -auto-approve || {
  echo "$ERR terraform destroy failed."
  exit 1
}

echo "$INFO All Terraform-managed resources destroyed ✅"
