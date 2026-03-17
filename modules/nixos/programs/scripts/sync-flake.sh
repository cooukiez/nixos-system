#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/etc/nixos"
cd "$REPO_DIR"

BRANCH=$(git branch --show-current)

# check if flake.lock actually has changes (check HEAD against working dir)
if ! git diff --quiet HEAD flake.lock 2>/dev/null; then
    echo "Changes detected in flake.lock."
    
    git add flake.lock
    git commit -m "chore: auto-update flake.lock" -- flake.lock
else
    echo "No changes found in flake.lock."
fi

echo "Fetching and merging upstream..."
git fetch origin
git merge origin/"$BRANCH" -X ours --no-edit -m "chore: merge upstream changes"

echo "Pushing changes to remote..."
git push origin "$BRANCH"

echo "Running permissions fix..."
fix-perms /etc/nixos

echo "Sync complete. Local files remain unchanged in your working directory."