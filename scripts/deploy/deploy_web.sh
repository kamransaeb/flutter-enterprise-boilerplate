#!/bin/bash

# Convenience wrapper for web deploy.
# Builds web for a flavor and deploys hosting to Firebase.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

FLAVOR="staging"
TARGET=""
PROJECT_ID=""
SKIP_BUILD=false

usage() {
    cat <<'EOF'
Usage: ./scripts/deploy/deploy_web.sh [options]

Options:
  -f, --flavor <dev|staging|prod>   Build flavor [default: staging]
  -t, --target <path>               Entry point [default: lib/main_<flavor>.dart]
  -p, --project-id <id>             Firebase project id (optional)
      --skip-build                  Skip web build and deploy existing build/web
  -h, --help                        Show this help message

Examples:
  ./scripts/deploy/deploy_web.sh
  ./scripts/deploy/deploy_web.sh -f prod
  ./scripts/deploy/deploy_web.sh -f dev -p my-project-id --skip-build
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
        -p|--project-id)
            PROJECT_ID="$2"
            shift 2
            ;;
        --skip-build)
            SKIP_BUILD=true
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

CMD=(./scripts/deploy/deploy_firebase.sh -f "$FLAVOR")
if [[ -n "$TARGET" ]]; then
    CMD+=(-t "$TARGET")
fi
if [[ -n "$PROJECT_ID" ]]; then
    CMD+=(-p "$PROJECT_ID")
fi
if [[ "$SKIP_BUILD" == true ]]; then
    CMD+=(--skip-build)
fi

echo "🌐 Deploying web hosting..."
echo "🏗️ Running: ${CMD[*]}"
"${CMD[@]}"
