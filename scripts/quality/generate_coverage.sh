#!/bin/bash

# Coverage generation script
# Practical baseline that works with current dependencies.

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "📊 Generating coverage..."

# Ensure dependencies are available
fvm flutter pub get

# Generate lcov report
fvm flutter test --coverage --test-randomize-ordering-seed=random

if [[ ! -f "coverage/lcov.info" ]]; then
    echo "❌ coverage/lcov.info was not generated."
    exit 1
fi

echo "✅ LCOV report generated at coverage/lcov.info"

# Optionally generate HTML report if lcov tools are installed.
if command -v genhtml >/dev/null 2>&1; then
    echo "🧾 Generating HTML coverage report..."
    genhtml coverage/lcov.info -o coverage/html
    echo "✅ HTML report generated at coverage/html/index.html"
else
    echo "ℹ️ genhtml not found; skipping HTML report."
    echo "   Install lcov to enable HTML output."
fi
