#!/bin/bash

# Build Android Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🔨 Building Android..."

# Clean
fvm flutter clean

# Get dependencies
fvm flutter pub get

# Run code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Analyze code
fvm flutter analyze --fatal-infos

# Run tests
fvm flutter test --coverage

# Build APK
fvm flutter build apk --release

# Build App Bundle
fvm flutter build appbundle --release

echo "✅ Android build completed!"