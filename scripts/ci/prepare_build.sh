#!/bin/bash

# CI pre-build steps script.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

RUN_CODEGEN=false
SKIP_TESTS=false
SKIP_ANALYZE=false

usage() {
    cat <<'EOF'
Usage: ./scripts/ci/prepare_build.sh [options]

Options:
  --codegen          Run build_runner before build
  --skip-tests       Skip flutter test
  --skip-analyze     Skip flutter analyze
  -h, --help         Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --codegen)
            RUN_CODEGEN=true
            shift
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        --skip-analyze)
            SKIP_ANALYZE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
done

if command -v fvm >/dev/null 2>&1; then
    FLUTTER_CMD="fvm flutter"
    DART_CMD="fvm dart"
else
    FLUTTER_CMD="flutter"
    DART_CMD="dart"
fi

echo "🚀 Preparing build..."
$FLUTTER_CMD pub get

if [[ "$RUN_CODEGEN" == true ]]; then
    echo "⚙️ Running code generation..."
    $DART_CMD run build_runner build --delete-conflicting-outputs
fi

if [[ "$SKIP_ANALYZE" != true ]]; then
    echo "🔎 Running static analysis..."
    $FLUTTER_CMD analyze --fatal-infos
fi

if [[ "$SKIP_TESTS" != true ]]; then
    echo "🧪 Running tests..."
    $FLUTTER_CMD test --test-randomize-ordering-seed=random
fi

echo "✅ Build preparation completed."
