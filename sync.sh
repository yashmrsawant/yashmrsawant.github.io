#!/bin/bash

# 1. Pull latest changes first to avoid merge conflicts
echo "⬇️ Pulling latest changes from remote..."
git pull origin main

# 2. Set the commit message
# If you don't provide a message, it defaults to a timestamped message
if [ -z "$1" ]
then
  COMMIT_MSG="Auto-commit: Update blog $(date +'%Y-%m-%d %H:%M:%S')"
else
  COMMIT_MSG="$1"
fi

# 3. Add all changes
echo "➕ Adding changes..."
git add .

# 4. Commit changes
echo "📝 Committing: '$COMMIT_MSG'"
git commit -m "$COMMIT_MSG"

# 5. Push to GitHub
echo "🚀 Pushing to main branch..."
git push origin main

echo "✅ Done! Your site is syncing."
