#!/bin/bash

# Build iOS release artifacts.

set -e
set -u
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=_common.sh
source "$SCRIPT_DIR/_common.sh"

FLAVOR="prod"
TARGET=""
SKIP_CLEAN=false
SKIP_CODEGEN=false
SKIP_ANALYZE=false
SKIP_TEST=false
ARCHIVE=false
POD_INSTALL=true
SHOW_HELP=false

SCHEME=""
CONFIGURATION=""
ARCHIVE_PATH="build/ios/archive/${FLAVOR}.xcarchive"
EXPORT_PATH="build/ios/ipa/${FLAVOR}"
EXPORT_OPTIONS_PLIST="${EXPORT_OPTIONS_PLIST:-}"

usage() {
    cat <<'EOF'
Usage: ./scripts/build/build_ios.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Build flavor [default: prod]
  -t, --target <path>                Entry point [default: lib/main_<flavor>.dart]
      --archive                      Archive and export IPA (requires signing setup)
      --skip-clean                   Skip flutter clean
      --skip-codegen                 Skip build_runner
      --skip-analyze                 Skip flutter analyze
      --skip-test                    Skip flutter test
      --skip-pod-install             Skip pod install
  -h, --help                         Show this help message

Archive mode environment:
  APPLE_TEAM_ID                      Required when using --archive
  EXPORT_OPTIONS_PLIST               Optional export plist path
                                     [default: ios/ExportOptions-<flavor>.plist
                                      or ios/ExportOptions.plist]

Examples:
  ./scripts/build/build_ios.sh -f dev
  ./scripts/build/build_ios.sh -f prod --archive
  APPLE_TEAM_ID=XXXXXXXXXX ./scripts/build/build_ios.sh -f prod --archive
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--flavor)
            FLAVOR="$2"
            shift 2
            ;;
        -t|--target)
            TARGET="$2"
            shift 2
            ;;
        --archive)
            ARCHIVE=true
            shift
            ;;
        --skip-clean)
            SKIP_CLEAN=true
            shift
            ;;
        --skip-codegen)
            SKIP_CODEGEN=true
            shift
            ;;
        --skip-analyze)
            SKIP_ANALYZE=true
            shift
            ;;
        --skip-test)
            SKIP_TEST=true
            shift
            ;;
        --skip-pod-install)
            POD_INSTALL=false
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option: '$1'"
            usage
            exit 1
            ;;
    esac
done

validate_project_root
validate_fvm
validate_flavor
resolve_build_target

SCHEME="$FLAVOR"
CONFIGURATION="Release-${FLAVOR}"
ARCHIVE_PATH="build/ios/archive/${FLAVOR}.xcarchive"
EXPORT_PATH="build/ios/ipa/${FLAVOR}"

if [[ -z "$EXPORT_OPTIONS_PLIST" ]]; then
    if [[ -f "ios/ExportOptions-${FLAVOR}.plist" ]]; then
        EXPORT_OPTIONS_PLIST="ios/ExportOptions-${FLAVOR}.plist"
    elif [[ -f "ios/ExportOptions.plist" ]]; then
        EXPORT_OPTIONS_PLIST="ios/ExportOptions.plist"
    fi
fi

echo "🍎 Building iOS release..."
print_build_config
echo "🔍 Scheme:        $SCHEME"
echo "🔍 Configuration: $CONFIGURATION"
run_preflight

if [[ "$POD_INSTALL" == true ]]; then
    echo "📦 Installing CocoaPods..."
    (cd ios && pod install --repo-update)
fi

echo "🏗️ Building iOS app..."
fvm flutter build ios --release --no-codesign --flavor "$FLAVOR" -t "$TARGET"

if [[ "$ARCHIVE" != true ]]; then
    echo "✅ iOS build completed (no archive/export)."
    echo "ℹ️ Use --archive to create an IPA."
    exit 0
fi

: "${APPLE_TEAM_ID:?APPLE_TEAM_ID is required when using --archive}"

if [[ -z "$EXPORT_OPTIONS_PLIST" || ! -f "$EXPORT_OPTIONS_PLIST" ]]; then
    echo "Error: Export options plist not found."
    echo "Create ios/ExportOptions-${FLAVOR}.plist or set EXPORT_OPTIONS_PLIST."
    exit 1
fi

mkdir -p "build/ios/archive" "build/ios/ipa/${FLAVOR}"

echo "📦 Archiving with xcodebuild..."
(
    cd ios
    xcodebuild archive \
        -workspace Runner.xcworkspace \
        -scheme "$SCHEME" \
        -configuration "$CONFIGURATION" \
        -archivePath "../${ARCHIVE_PATH}" \
        -allowProvisioningUpdates \
        -destination generic/platform=iOS \
        DEVELOPMENT_TEAM="$APPLE_TEAM_ID"
)

echo "📤 Exporting IPA..."
(
    cd ios
    xcodebuild -exportArchive \
        -archivePath "../${ARCHIVE_PATH}" \
        -exportOptionsPlist "../${EXPORT_OPTIONS_PLIST}" \
        -exportPath "../${EXPORT_PATH}" \
        -allowProvisioningUpdates
)

echo "✅ iOS archive and export completed!"
echo "📦 IPA available at: ${EXPORT_PATH}"
