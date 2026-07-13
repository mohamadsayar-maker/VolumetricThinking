#!/usr/bin/env bash
# Push the landing page to GitHub Pages.  Usage:  ./deploy.sh "what changed"
set -e
cd "$(dirname "$0")"
REMOTE="https://github.com/mohamadsayar-maker/VolumetricThinking.git"
MSG="${1:-Update site}"

if [ ! -d .git ]; then
  git init -b main
  git remote add origin "$REMOTE"
fi
git remote set-url origin "$REMOTE"

# self-heal: drop the accidental nested repo folder if it reappears
if [ -e VolumetricThinking ]; then
  git rm -r --cached VolumetricThinking 2>/dev/null || true
  rm -rf VolumetricThinking
fi

git add -A
git commit -m "$MSG" || echo "Nothing new to commit."
git branch -M main

# this folder is the single source of truth, so overwrite the remote
# rather than merging (avoids conflict markers). Safe for a solo repo.
git push --force-with-lease origin main || git push --force origin main

echo "Pushed. Live in ~1-2 min at:"
echo "https://mohamadsayar-maker.github.io/VolumetricThinking/"
