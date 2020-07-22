#!/bin/sh

set -e

echo "Running dartdoc..."
dartdoc

echo ""
echo "Done."
echo ""

if [ -z "$(git status --porcelain)" ]; then
  exit 0
else
  echo "! Documentation not generated. Make sure to run ./scripts/pre_commit.sh and push again."
  echo "! git status:"
  git status
  exit 1
fi