#!/usr/bin/env bash
# Push the landing page to GitHub Pages. Usage:  ./deploy.sh "what changed"
set -e
cd "$(dirname "$0")"
REMOTE="https://github.com/mohamadsayar-maker/VolumetricThinking.git"
MSG="${1:-Update site}"

if [ ! -d .git ]; then
  git init -b main
  git remote add origin "$REMOTE"
fi
git remote set-url origin "$REMOTE"

git add -A
git commit -m "$MSG" || { echo "Nothing new to commit."; }
git branch -M main

# first push may need to reconcile an existing README commit on GitHub
if ! git push -u origin main 2>/dev/null; then
  echo "Reconciling with remote…"
  git pull --rebase origin main
  git push -u origin main
fi
echo "Done. Live in ~1-2 min at:"
echo "https://mohamadsayar-maker.github.io/VolumetricThinking/"
