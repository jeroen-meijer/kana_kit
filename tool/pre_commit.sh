#!/bin/sh

echo "Running dart format..."
dart format .
echo "Running dart analyze..."
dart analyze --fatal-infos --fatal-warnings lib test
echo "Running coverage..."
rm -rf ./coverage
dart run coverage:test_with_coverage
lcov --remove ./coverage/lcov.info -o ./coverage/filtered.info\
  '**/*.g.dart' \
  'lib/src/models/romanization/**'
genhtml -o coverage ./coverage/filtered.info
open ./coverage/index.html
echo "Running dry run publish..."
dart pub publish --dry-run

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
