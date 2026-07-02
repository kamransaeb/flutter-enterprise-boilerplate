#!/bin/bash

# Basic environment and project health checks.

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

echo "🩺 Running health checks..."
echo "▶ Flutter version"
$FLUTTER_CMD --version

echo "▶ Dart version"
$DART_CMD --version

echo "▶ Flutter doctor"
$FLUTTER_CMD doctor -v

echo "▶ Dependency resolution check"
$FLUTTER_CMD pub get

echo "▶ Analyzer quick check"
$FLUTTER_CMD analyze --fatal-infos

echo "✅ Health check completed."
