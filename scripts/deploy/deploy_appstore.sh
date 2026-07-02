#!/bin/bash

# Build and optionally upload iOS IPA to App Store Connect.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

FLAVOR="prod"
TARGET=""
BUILD_FIRST=true
UPLOAD=false
IPA_PATH=""

usage() {
    cat <<'EOF'
Usage: ./scripts/deploy/deploy_appstore.sh [options]

Options:
  -f, --flavor <dev|staging|prod>   Build flavor [default: prod]
  -t, --target <path>               Entry point [default: lib/main_<flavor>.dart]
  --artifact <path>                 Existing .ipa path (skip auto-discovery)
  --no-build                        Skip build/archive and use existing .ipa
  --upload                          Upload to App Store Connect using Fastlane Pilot
  -h, --help                        Show this help message

Build requirements (when --no-build is NOT used):
  APPLE_TEAM_ID                     Required by build_ios.sh --archive
  EXPORT_OPTIONS_PLIST              Optional (or create ios/ExportOptions-<flavor>.plist)

Upload requirements (--upload):
  APP_STORE_CONNECT_API_KEY_PATH    App Store Connect API key .p8 path
  APP_STORE_CONNECT_API_KEY_ID      API key ID
  APP_STORE_CONNECT_ISSUER_ID       API issuer ID

Examples:
  APPLE_TEAM_ID=XXXXXXXXXX ./scripts/deploy/deploy_appstore.sh -f prod
  ./scripts/deploy/deploy_appstore.sh --no-build --artifact build/ios/ipa/prod/Runner.ipa --upload
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
        --artifact)
            IPA_PATH="$2"
            shift 2
            ;;
        --no-build)
            BUILD_FIRST=false
            shift
            ;;
        --upload)
            UPLOAD=true
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

case "$FLAVOR" in
    dev|staging|prod) ;;
    *)
        echo "Error: Invalid flavor: '$FLAVOR'. Use dev, staging, or prod."
        exit 1
        ;;
esac

if [[ -z "$TARGET" ]]; then
    TARGET="lib/main_${FLAVOR}.dart"
fi

if [[ "$BUILD_FIRST" == true ]]; then
    echo "🍎 Building and archiving iOS app for '$FLAVOR'..."
    ./scripts/build/build_ios.sh -f "$FLAVOR" -t "$TARGET" --archive
fi

if [[ -z "$IPA_PATH" ]]; then
    IPA_PATH="build/ios/ipa/${FLAVOR}/Runner.ipa"
fi

if [[ ! -f "$IPA_PATH" ]]; then
    echo "Error: IPA not found at '$IPA_PATH'."
    echo "Pass --artifact with the correct IPA path."
    exit 1
fi

echo "✅ IPA ready: $IPA_PATH"

if [[ "$UPLOAD" != true ]]; then
    echo "ℹ️ Archive complete. Use --upload to publish via Fastlane Pilot."
    exit 0
fi

if ! command -v fastlane >/dev/null 2>&1; then
    echo "Error: fastlane is required for --upload."
    echo "Install with: brew install fastlane (or gem install fastlane)"
    exit 1
fi

: "${APP_STORE_CONNECT_API_KEY_PATH:?APP_STORE_CONNECT_API_KEY_PATH is required for --upload}"
: "${APP_STORE_CONNECT_API_KEY_ID:?APP_STORE_CONNECT_API_KEY_ID is required for --upload}"
: "${APP_STORE_CONNECT_ISSUER_ID:?APP_STORE_CONNECT_ISSUER_ID is required for --upload}"

echo "🚀 Uploading IPA to App Store Connect..."
fastlane pilot upload \
    --ipa "$IPA_PATH" \
    --api_key_path "$APP_STORE_CONNECT_API_KEY_PATH" \
    --api_key_id "$APP_STORE_CONNECT_API_KEY_ID" \
    --issuer_id "$APP_STORE_CONNECT_ISSUER_ID"

echo "✅ App Store upload completed!"
