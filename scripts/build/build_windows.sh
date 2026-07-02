#!/bin/bash

# Build Windows release artifacts.

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

usage() {
    cat <<'EOF'
Usage: ./scripts/build/build_windows.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Build flavor [default: prod]
  -t, --target <path>                Entry point [default: lib/main_<flavor>.dart]
      --skip-clean                   Skip flutter clean
      --skip-codegen                 Skip build_runner
      --skip-analyze                 Skip flutter analyze
      --skip-test                    Skip flutter test
  -h, --help                         Show this help message

Examples:
  ./scripts/build/build_windows.sh
  ./scripts/build/build_windows.sh -f staging
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

echo "🪟 Building Windows release..."
print_build_config
run_preflight

echo "🏗️ Building Windows app..."
$FLUTTER_CMD build windows --release -t "$TARGET"

echo "✅ Windows build completed!"
echo "📦 Output: build/windows/x64/runner/Release"
