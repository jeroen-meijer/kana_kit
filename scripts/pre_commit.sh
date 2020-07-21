#!/bin/sh
set -e

echo "Running dartanalyzer..."
dartanalyzer .
echo "Running dartfmt..."
dartfmt -w .

echo ""
echo "Done."
echo ""

if [ -z "$(git status --porcelain)" ]; then
  echo "Working directory clean."
  exit 0
else
  echo "! Uncommitted changes detected. Please push the new changes to this branch."
  exit 1
fi