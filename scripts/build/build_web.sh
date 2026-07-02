#!/bin/bash

# Build web release artifacts.

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
WEB_RENDERER=""

usage() {
    cat <<'EOF'
Usage: ./scripts/build/build_web.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Build flavor [default: prod]
  -t, --target <path>                Entry point [default: lib/main_<flavor>.dart]
      --web-renderer <canvaskit|html> Optional web renderer
      --skip-clean                   Skip flutter clean
      --skip-codegen                 Skip build_runner
      --skip-analyze                 Skip flutter analyze
      --skip-test                    Skip flutter test
  -h, --help                         Show this help message

Examples:
  ./scripts/build/build_web.sh
  ./scripts/build/build_web.sh -f dev
  ./scripts/build/build_web.sh -f staging --web-renderer canvaskit
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
        --web-renderer)
            WEB_RENDERER="$2"
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

echo "🌐 Building web release..."
print_build_config
run_preflight

BUILD_CMD=($FLUTTER_CMD build web --release -t "$TARGET")

if [[ -n "$WEB_RENDERER" ]]; then
    BUILD_CMD+=(--web-renderer "$WEB_RENDERER")
fi

echo "🏗️ Running: ${BUILD_CMD[*]}"
"${BUILD_CMD[@]}"

echo "✅ Web build completed!"
echo "📦 Output: build/web"
