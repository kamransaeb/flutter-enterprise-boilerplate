#!/bin/bash

# Clean project artifacts and refresh dependencies.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

if command -v fvm >/dev/null 2>&1; then
    FLUTTER_CMD="fvm flutter"
else
    FLUTTER_CMD="flutter"
fi

echo "🧹 Cleaning Flutter project..."
$FLUTTER_CMD clean

echo "🗑️ Removing generated tool/cache files..."
rm -rf .dart_tool
rm -rf build
rm -rf pubspec.lock

echo "📦 Refreshing dependencies..."
$FLUTTER_CMD pub get

echo "✅ Project cleaned and refreshed."
