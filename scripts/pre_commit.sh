#!/bin/sh

echo "Running dartanalyzer..."
dartanalyzer .
echo "Running dartfmt..."
dartfmt -w .
echo "Running codecov..."
rm -rf ./coverage
pub run test_coverage --no-badge --min-coverage 100
lcov --remove ./coverage/lcov.info -o ./coverage/filtered.info\
  '**/*.g.dart' \
  'lib/src/models/romanization/**'
genhtml -o coverage ./coverage/filtered.info
open ./coverage/index.html

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