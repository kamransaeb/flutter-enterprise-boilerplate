#!/bin/bash

# Test runner script
# Practical baseline that works with current pubspec dependencies.

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🧪 Running tests..."

# Ensure dependencies are available
fvm flutter pub get

echo "🔬 Running unit and widget tests..."
fvm flutter test --test-randomize-ordering-seed=random

echo "🔗 Running integration tests (if present)..."
if [[ -d "integration_test" ]]; then
    # If no integration test files exist, skip gracefully.
    shopt -s nullglob
    integration_files=(integration_test/*_test.dart)
    shopt -u nullglob

    if [[ ${#integration_files[@]} -gt 0 ]]; then
        fvm flutter test integration_test
    else
        echo "ℹ️ No integration test files found in integration_test/."
    fi
else
    echo "ℹ️ No integration_test directory found."
fi

echo "✅ Test run completed!"
