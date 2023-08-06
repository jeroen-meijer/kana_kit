#!/bin/sh

echo "Running dartfmt..."
dartfmt -w .
echo "Running dartanalyzer..."
dart analyzer --fatal-infos --fatal-warnings lib test
echo "Running codecov..."
rm -rf ./coverage
dart test --coverage=coverage
lcov --remove ./coverage/lcov.info -o ./coverage/filtered.info\
  '**/*.g.dart' \
  'lib/src/models/romanization/**'
genhtml -o coverage ./coverage/filtered.info
open ./coverage/index.html
echo "Running dry run publish..."
dart publish --dry-run

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
