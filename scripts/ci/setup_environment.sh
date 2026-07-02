#!/bin/bash

# CI environment setup script.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

if command -v fvm >/dev/null 2>&1; then
    FLUTTER_CMD="fvm flutter"
    DART_CMD="fvm dart"
else
    FLUTTER_CMD="flutter"
    DART_CMD="dart"
fi

echo "🛠️ Setting up CI environment..."
$FLUTTER_CMD --version
$DART_CMD --version

echo "📦 Fetching dependencies..."
$FLUTTER_CMD pub get

echo "✅ CI environment setup complete."
