#!/bin/bash
# Generate native splash screens for one or all flavors.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

FLAVOR="dev"
GENERATE_ALL=false

usage() {
    cat <<'EOF'
Usage: ./scripts/codegen/generate_splash.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Flavor config to use [default: dev]
  -a, --all                          Generate splash screens for dev, staging, and prod
  -h, --help                         Show this help message

Config files:
  flutter_native_splash_dev.yaml
  flutter_native_splash_staging.yaml
  flutter_native_splash_prod.yaml

Examples:
  ./scripts/codegen/generate_splash.sh
  ./scripts/codegen/generate_splash.sh -f staging
  ./scripts/codegen/generate_splash.sh --all
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--flavor)
            FLAVOR="$2"
            shift 2
            ;;
        -a|--all)
            GENERATE_ALL=true
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

if ! command -v fvm &> /dev/null; then
    echo "Error: fvm is not installed or not in PATH."
    exit 1
fi

if ! fvm dart run flutter_native_splash:create --help >/dev/null 2>&1; then
    echo "Error: flutter_native_splash is not available."
    echo "Add it to pubspec.yaml and run 'fvm flutter pub get'."
    exit 1
fi

generate_splash_for_flavor() {
    local flavor="$1"
    local config_file="flutter_native_splash_${flavor}.yaml"

    case "$flavor" in
        dev|staging|prod) ;;
        *)
            echo "Error: Invalid flavor: '$flavor'. Use dev, staging, or prod."
            exit 1
            ;;
    esac

    if [[ ! -f "$config_file" ]]; then
        echo "Error: Config file not found: '$config_file'"
        exit 1
    fi

    echo "💧 Generating splash screen for '$flavor' using '$config_file'..."
    fvm dart run flutter_native_splash:create --path="$config_file"
    echo "✅ Splash screen generated for '$flavor'."
}

echo "🚀 Starting splash screen generation..."
fvm flutter pub get

if [[ "$GENERATE_ALL" == true ]]; then
    generate_splash_for_flavor dev
    generate_splash_for_flavor staging
    generate_splash_for_flavor prod
else
    generate_splash_for_flavor "$FLAVOR"
fi

echo "🎉 Splash screen generation completed!"
