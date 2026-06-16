#!/bin/bash

# Linting Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

# check if fvm is installed
if ! command -v fvm >/dev/null 2>&1; then
    echo "Error: fvm is not installed"
    exit 1
fi

echo "🔍 Running code analysis..."

# Run dart analyze
fvm dart analyze --fatal-infos

# Run custom lint
fvm dart run custom_lint

# Run dart code metrics
fvm dart run dart_code_metrics:metrics analyze lib --reporter=html
fvm dart run dart_code_metrics:metrics check-unused-files lib
fvm dart run dart_code_metrics:metrics check-unused-code lib

echo "✅ Code analysis completed!"