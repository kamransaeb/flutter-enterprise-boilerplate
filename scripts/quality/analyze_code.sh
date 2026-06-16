#!/bin/bash

# Code Quality Analysis Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🔍 Starting code analysis..."

# Run dart analyze
echo "📊 Running dart analyze..."
fvm dart analyze --fatal-infos

# Run custom lint
echo "✨ Running custom lint..."
fvm dart run custom_lint

# Run dart code metrics
echo "📈 Running dart code metrics..."
fvm dart run dart_code_metrics:metrics analyze lib \
  --reporter=html \
  --reporter=codeclimate \
  --reporter=github \
  --set-exit-on-violation-level=warning

# Check for unused files
echo "🗑️ Checking for unused files..."
fvm dart run dart_code_metrics:metrics check-unused-files lib

# Check for unused code
echo "🧹 Checking for unused code..."
fvm dart run dart_code_metrics:metrics check-unused-code lib

# Check for long methods
echo "⏱️ Checking for long methods..."
fvm dart run dart_code_metrics:metrics check-unnecessary-nullable-parameters lib

# Calculate cyclomatic complexity
echo "🌀 Calculating cyclomatic complexity..."
fvm dart run dart_code_metrics:metrics check-method-source-lines-of-code lib

# Run dependency validation
echo "📦 Validating dependencies..."
fvm dart run dependency_validator

# Check for outdated dependencies
echo "🔄 Checking for outdated dependencies..."
fvm flutter pub outdated

# Run format check
echo "🎨 Checking code format..."
fvm dart format --set-exit-if-changed .

# Run size analysis
echo "📏 Analyzing code size..."
# Use a gate so the script works on both old/new Flutter versions
if (fvm flutter analyze --help | grep -q -- "--size"); then
    fvm flutter analyze --size
else
    echo "Code size analysis not supported by this version of Flutter"
fi

# Generate code coverage report
echo "📊 Generating code coverage report..."
fvm flutter test --coverage

if command -v genhtml >/dev/null 2>&1; then
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html 2>/dev/null || echo "Coverage report generated at coverage/html/index.html"
else 
    echo "genhtml not installed; skipping"
    echo "LCOV report generated at coverage/lcov.info"
    echo "To view the coverage report, run: genhtml coverage/lcov.info -o coverage/html"
fi

echo "✅ Code analysis completed!"