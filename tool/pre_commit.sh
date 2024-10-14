#!/bin/sh

function print_bold() {
  echo "\033[1m$1\033[0m"
}

print_bold "Formatting..."
fvm dart format lib test

print_bold "Analyzing..."
fvm dart analyze --fatal-infos --fatal-warnings lib test

print_bold "Running codecov..."
rm -rf ./coverage

fvm dart run coverage:test_with_coverage
lcov --remove ./coverage/lcov.info -o ./coverage/filtered.info\
  '**/*.g.dart' \
  'lib/src/models/romanization/**'
genhtml -o coverage ./coverage/filtered.info
open ./coverage/index.html

print_bold "Running dry run publish..."
fvm dart pub publish --dry-run

print_bold ""
print_bold "Done."
print_bold ""

if [ -z "$(git status --porcelain)" ]; then
  print_bold "Working directory clean."
  exit 0
else
  print_bold "! Uncommitted changes detected. Please push the new changes to this branch."
  exit 1
fi
