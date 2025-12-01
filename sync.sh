#!/usr/bin/env bash
set -euo pipefail

# Colors for nicer output (optional)
INFO="[INFO]"
WARN="[WARN]"
ERR="[ERROR]"

echo "$INFO Starting sync..."

# 1. Ensure we're inside a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "$ERR This is not a git repository. Aborting."
  exit 1
fi

# 2. Detect current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "$INFO Current branch: $CURRENT_BRANCH"

# 3. Ensure "origin" remote exists
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "$ERR Remote 'origin' is not set. Add it with:"
  echo "     git remote add origin <your-repo-url>"
  exit 1
fi

# 4. Pull latest changes with rebase
echo "$INFO Pulling latest changes from origin/$CURRENT_BRANCH..."
if ! git pull --rebase origin "$CURRENT_BRANCH"; then
  echo "$ERR git pull failed. Resolve conflicts and re-run ./sync.sh."
  exit 1
fi

# 5. Stage changes
echo "$INFO Staging changes..."
git add .

# 6. Check if there is anything to commit
if git diff --cached --quiet; then
  echo "$WARN No changes to commit. Nothing to push."
  exit 0
fi

# 7. Commit
COMMIT_MESSAGE=${1:-"Synced changes"}
echo "$INFO Committing with message: $COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

# 8. Push
echo "$INFO Pushing to origin/$CURRENT_BRANCH..."
if ! git push origin "$CURRENT_BRANCH"; then
  echo "$ERR git push failed. Please check your connection/permissions."
  exit 1
fi

echo "$INFO Sync completed successfully ✅"
