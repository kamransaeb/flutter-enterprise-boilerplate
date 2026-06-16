#!/bin/bash

# iOS Build Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🍎 Building iOS..."

# Configuration
APP_NAME="EnterpriseApp"
SCHEME="Runner"
CONFIGURATION="Release"
EXPORT_METHOD="app-store"
: "${APPLE_TEAM_ID:?APPLE_TEAM_ID is required}"
TEAM_ID=${APPLE_TEAM_ID}
PROFILE_NAME="EnterpriseApp Distribution"

# Clean
fvm flutter clean
rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec

# Get dependencies
fvm flutter pub get

# Run code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Analyze code
fvm flutter analyze --fatal-infos

# Run tests
fvm flutter test --coverage

# Update pods
cd ios
pod install --repo-update
cd ..

# Build iOS
fvm flutter build ios --release --no-codesign

# Archive
cd ios
xcodebuild archive \
  -workspace Runner.xcworkspace \
  -scheme $SCHEME \
  -configuration $CONFIGURATION \
  -archivePath ../build/ios/archive/Runner.xcarchive \
  -allowProvisioningUpdates \
  -destination generic/platform=iOS \
  CODE_SIGN_STYLE="Manual" \
  PROVISIONING_PROFILE_SPECIFIER="$PROFILE_NAME" \
  DEVELOPMENT_TEAM="$TEAM_ID"

# Export IPA
xcodebuild -exportArchive \
  -archivePath ../build/ios/archive/Runner.xcarchive \
  -exportOptionsPlist ../ios/ExportOptions.plist \
  -exportPath ../build/ios/ipa \
  -allowProvisioningUpdates

cd ..

echo "✅ iOS build completed!"
echo "📦 IPA available at: build/ios/ipa/Runner.ipa"