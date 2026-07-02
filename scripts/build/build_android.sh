#!/bin/bash

# Build Android release artifacts (APK and/or App Bundle).

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
BUILD_APK=true
BUILD_BUNDLE=true
SHOW_HELP=false

usage() {
    cat <<'EOF'
Usage: ./scripts/build/build_android.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Build flavor [default: prod]
  -t, --target <path>                Entry point [default: lib/main_<flavor>.dart]
      --apk-only                     Build APK only
      --bundle-only                  Build App Bundle only
      --skip-clean                   Skip flutter clean
      --skip-codegen                 Skip build_runner
      --skip-analyze                 Skip flutter analyze
      --skip-test                    Skip flutter test
  -h, --help                         Show this help message

Examples:
  ./scripts/build/build_android.sh
  ./scripts/build/build_android.sh -f dev --apk-only
  ./scripts/build/build_android.sh -f staging --skip-test
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
        --apk-only)
            BUILD_APK=true
            BUILD_BUNDLE=false
            shift
            ;;
        --bundle-only)
            BUILD_APK=false
            BUILD_BUNDLE=true
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

echo "🤖 Building Android release..."
print_build_config
run_preflight

if [[ "$BUILD_APK" == true ]]; then
    echo "📦 Building APK..."
    $FLUTTER_CMD build apk --release --flavor "$FLAVOR" -t "$TARGET"
    echo "✅ APK build completed."
fi

if [[ "$BUILD_BUNDLE" == true ]]; then
    echo "📦 Building App Bundle..."
    $FLUTTER_CMD build appbundle --release --flavor "$FLAVOR" -t "$TARGET"
    echo "✅ App Bundle build completed."
fi

echo "🎉 Android build completed!"
