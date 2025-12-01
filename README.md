# 📘 Terraform Mini Project — EC2 + GitHub Repo Automation

This project demonstrates how to use Terraform to:

* Create an EC2 instance on Amazon Web Services (disabled by default using `count = 0`)
* Create a repository on GitHub
* Manage your Terraform project safely with `.gitignore`
* Securely store secrets in `secrets.auto.tfvars`
* Sync your local repo with GitHub using a safe `sync.sh` script
* Destroy infrastructure cleanly with `destroy.sh`

Simple, secure, and perfect for learning Terraform basics.

---

## ✅ Prerequisites

Make sure these are installed and configured on your system:

### • Terraform

Install from: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)

### • AWS CLI (configured)

Configure credentials:

```bash
aws configure
```

### • GitHub Personal Access Token (PAT)

Create a PAT with:

* `repo`
* `workflow`
* (optional) `admin:repo_hook`

---

## 🔐 Secrets Setup

Create this file locally (never commit it):

### `secrets.auto.tfvars`

```hcl
github_pat = "ghp_your_actual_token_here"
```

This file is ignored by `.gitignore`.

---

## 📂 Project Structure

```
.
├── main.tf
├── providers.tf
├── .gitignore
├── sync.sh
├── destroy.sh
├── Makefile (optional)
└── secrets.auto.tfvars (ignored)
```

---

## ▶️ Using Terraform

### Initialize

```bash
terraform init
```

### Plan

```bash
terraform plan
```

### Apply

```bash
terraform apply
```

By default:

* EC2 instance **will NOT be created** (`count = 0`)
* GitHub repo **WILL be created**

To launch the EC2 instance, change:

```hcl
count = 1
```

---

## 🔄 Sync Local Repo to GitHub

Run:

```bash
./sync.sh
```

Or with a custom commit message:

```bash
./sync.sh "Updated Terraform config"
```

The script:

* Checks if you’re in a git repo
* Safely rebases latest changes
* Commits only if changes exist
* Pushes to the current branch

---

## 💣 Destroy All Terraform Resources Safely

Run:

```bash
./destroy.sh
```

The script:

* Confirms you're in a Terraform directory
* Shows a destroy plan
* Asks for confirmation (`yes`)
* Executes safe destroy with error handling

---

## 🛠 Optional: Makefile

For convenience, you can run:

```Makefile
sync:
	./sync.sh

destroy:
	./destroy.sh
```

Usage:

```bash
make sync
make destroy
```

---

## ⚠️ Important Notes

* Never commit `secrets.auto.tfvars`
* Never commit AWS credentials, GitHub PATs, or `.env` files
* Terraform state files contain sensitive info → also ignored by `.gitignore`
* EC2 resource uses `count = 0` to avoid AWS charges

---

