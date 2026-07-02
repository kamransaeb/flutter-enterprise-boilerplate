#!/bin/bash

# Update dependencies with safe defaults.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

MAJOR=false

usage() {
    cat <<'EOF'
Usage: ./scripts/tools/update_dependencies.sh [options]

Options:
  --major            Allow major version upgrades
  -h, --help         Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --major)
            MAJOR=true
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

echo "🔍 Checking outdated dependencies..."
$FLUTTER_CMD pub outdated

echo "⬆️ Upgrading dependencies..."
if [[ "$MAJOR" == true ]]; then
    $DART_CMD pub upgrade --major-versions
else
    $DART_CMD pub upgrade
fi

echo "📦 Refreshing lockfile..."
$FLUTTER_CMD pub get

echo "✅ Dependency update completed."
