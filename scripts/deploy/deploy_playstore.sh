#!/bin/bash

# Deploy Android app bundle to Google Play.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

FLAVOR="prod"
TARGET=""
TRACK="internal"
BUILD_FIRST=true
UPLOAD=false
AAB_PATH=""

usage() {
    cat <<'EOF'
Usage: ./scripts/deploy/deploy_playstore.sh [options]

Options:
  -f, --flavor <dev|staging|prod>   Build flavor [default: prod]
  -t, --target <path>               Entry point [default: lib/main_<flavor>.dart]
  --track <internal|alpha|beta|production>
                                    Google Play track [default: internal]
  --artifact <path>                 Existing .aab path (skip auto-discovery)
  --no-build                        Skip build and use existing .aab
  --upload                          Upload to Play Store using Fastlane Supply
  -h, --help                        Show this help message

Upload requirements (--upload):
  SUPPLY_JSON_KEY                   Service account json key path
  SUPPLY_PACKAGE_NAME               Android package name

Examples:
  ./scripts/deploy/deploy_playstore.sh
  ./scripts/deploy/deploy_playstore.sh -f prod --upload --track production
  ./scripts/deploy/deploy_playstore.sh --no-build --artifact build/app/outputs/bundle/prodRelease/app-prod-release.aab --upload
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
        --track)
            TRACK="$2"
            shift 2
            ;;
        --artifact)
            AAB_PATH="$2"
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
    echo "🤖 Building Android App Bundle for '$FLAVOR'..."
    ./scripts/build/build_android.sh -f "$FLAVOR" -t "$TARGET" --bundle-only
fi

if [[ -z "$AAB_PATH" ]]; then
    AAB_PATH="build/app/outputs/bundle/${FLAVOR}Release/app-${FLAVOR}-release.aab"
fi

if [[ ! -f "$AAB_PATH" ]]; then
    echo "Error: App Bundle not found at '$AAB_PATH'."
    echo "Pass --artifact with the correct path."
    exit 1
fi

echo "✅ App Bundle ready: $AAB_PATH"

if [[ "$UPLOAD" != true ]]; then
    echo "ℹ️ Build complete. Use --upload to publish via Fastlane Supply."
    exit 0
fi

if ! command -v fastlane >/dev/null 2>&1; then
    echo "Error: fastlane is required for --upload."
    echo "Install with: brew install fastlane (or gem install fastlane)"
    exit 1
fi

: "${SUPPLY_JSON_KEY:?SUPPLY_JSON_KEY is required for --upload}"
: "${SUPPLY_PACKAGE_NAME:?SUPPLY_PACKAGE_NAME is required for --upload}"

echo "🚀 Uploading App Bundle to Google Play track '$TRACK'..."
fastlane supply \
    --aab "$AAB_PATH" \
    --json_key "$SUPPLY_JSON_KEY" \
    --package_name "$SUPPLY_PACKAGE_NAME" \
    --track "$TRACK"

echo "✅ Play Store upload completed!"
