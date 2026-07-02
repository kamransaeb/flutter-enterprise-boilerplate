#!/bin/bash

# Deploy web and optional Firebase resources by flavor.

set -e
set -u
set -o pipefail

if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

if ! command -v firebase >/dev/null 2>&1; then
    echo "Error: firebase CLI is not installed."
    echo "Install with: npm install -g firebase-tools"
    exit 1
fi

FLAVOR="staging"
TARGET=""
PROJECT_ID=""
SKIP_BUILD=false
DEPLOY_FUNCTIONS=false
DEPLOY_FIRESTORE_RULES=false
DEPLOY_STORAGE_RULES=false
ONLY_HOSTING=true

usage() {
    cat <<'EOF'
Usage: ./scripts/deploy/deploy_firebase.sh [options]

Options:
  -f, --flavor <dev|staging|prod>   Build flavor [default: staging]
  -t, --target <path>               Entry point [default: lib/main_<flavor>.dart]
  -p, --project-id <id>             Firebase project id (required if no default mapping)
      --skip-build                  Skip web build and deploy current build/web
      --with-functions              Also deploy Cloud Functions
      --with-firestore-rules        Also deploy Firestore rules
      --with-storage-rules          Also deploy Storage rules
      --all                         Deploy hosting + functions + rules
  -h, --help                        Show this help message

Environment:
  FIREBASE_TOKEN                    Required for CI / non-interactive deploy
  FIREBASE_PROJECT_ID               Optional fallback project id

Examples:
  ./scripts/deploy/deploy_firebase.sh -f staging
  ./scripts/deploy/deploy_firebase.sh -f prod --all
  ./scripts/deploy/deploy_firebase.sh -f dev -p my-project-id --skip-build
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
        --with-functions)
            DEPLOY_FUNCTIONS=true
            ONLY_HOSTING=false
            shift
            ;;
        --with-firestore-rules)
            DEPLOY_FIRESTORE_RULES=true
            ONLY_HOSTING=false
            shift
            ;;
        --with-storage-rules)
            DEPLOY_STORAGE_RULES=true
            ONLY_HOSTING=false
            shift
            ;;
        --all)
            DEPLOY_FUNCTIONS=true
            DEPLOY_FIRESTORE_RULES=true
            DEPLOY_STORAGE_RULES=true
            ONLY_HOSTING=false
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

if [[ ! -f "$TARGET" ]]; then
    echo "Error: Target file not found: '$TARGET'"
    exit 1
fi

if [[ -z "$PROJECT_ID" ]]; then
    case "$FLAVOR" in
        dev) PROJECT_ID="lamberb-com-dev" ;;
        staging) PROJECT_ID="lamberb-com-staging" ;;
        prod) PROJECT_ID="lamberb-com-prod" ;;
    esac
fi

if [[ -n "${FIREBASE_PROJECT_ID:-}" ]]; then
    PROJECT_ID="${FIREBASE_PROJECT_ID}"
fi

if [[ -z "$PROJECT_ID" ]]; then
    echo "Error: Firebase project id is required."
    echo "Pass --project-id or set FIREBASE_PROJECT_ID."
    exit 1
fi

if [[ "$SKIP_BUILD" != true ]]; then
    echo "🌐 Building web for flavor '$FLAVOR'..."
    ./scripts/build/build_web.sh -f "$FLAVOR" -t "$TARGET"
fi

echo "🚀 Deploying to Firebase..."
echo "🔍 Project: $PROJECT_ID"
echo "🔍 Flavor:  $FLAVOR"

if [[ -n "${FIREBASE_TOKEN:-}" ]]; then
    export FIREBASE_TOKEN
fi

DEPLOY_TARGETS="hosting"
if [[ "$DEPLOY_FUNCTIONS" == true ]]; then
    DEPLOY_TARGETS="${DEPLOY_TARGETS},functions"
fi
if [[ "$DEPLOY_FIRESTORE_RULES" == true ]]; then
    DEPLOY_TARGETS="${DEPLOY_TARGETS},firestore:rules"
fi
if [[ "$DEPLOY_STORAGE_RULES" == true ]]; then
    DEPLOY_TARGETS="${DEPLOY_TARGETS},storage:rules"
fi

firebase deploy \
    --project "$PROJECT_ID" \
    --only "$DEPLOY_TARGETS" \
    --message "Release ${FLAVOR} $(date +%Y%m%d-%H%M%S)"

echo "✅ Firebase deployment completed!"
if [[ "$ONLY_HOSTING" == true ]]; then
    echo "🌍 Hosting URL: https://${PROJECT_ID}.web.app"
fi