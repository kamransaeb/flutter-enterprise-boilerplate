#!/bin/bash

# Shared helpers for release build scripts.

validate_project_root() {
    if [[ ! -f "pubspec.yaml" ]]; then
        echo "Error: This script must be run from the project root directory."
        exit 1
    fi
}

validate_fvm() {
    if ! command -v fvm &> /dev/null; then
        echo "Error: fvm is not installed or not in PATH."
        exit 1
    fi
}

validate_flavor() {
    case "$FLAVOR" in
        dev|staging|prod) ;;
        *)
            echo "Error: Invalid flavor: '$FLAVOR'. Use dev, staging, or prod."
            exit 1
            ;;
    esac
}

resolve_build_target() {
    if [[ -z "$TARGET" ]]; then
        TARGET="lib/main_${FLAVOR}.dart"
    fi

    if [[ ! -f "$TARGET" ]]; then
        echo "Error: Target file not found: '$TARGET'"
        exit 1
    fi

    ENV_FILE=".env.${FLAVOR}"
    if [[ ! -f "$ENV_FILE" ]]; then
        echo "Error: Environment file not found: '$ENV_FILE'"
        exit 1
    fi
}

print_build_config() {
    echo "🔍 Flavor:      $FLAVOR"
    echo "🔍 Target:      $TARGET"
    echo "🔍 Environment: $ENV_FILE"
}

run_preflight() {
    if [[ "$SKIP_CLEAN" != true ]]; then
        echo "🧹 Cleaning project..."
        fvm flutter clean
    fi

    echo "📦 Fetching dependencies..."
    fvm flutter pub get

    if [[ "$SKIP_CODEGEN" != true ]]; then
        echo "⚙️ Running code generation..."
        fvm dart run build_runner build --delete-conflicting-outputs
    fi

    if [[ "$SKIP_ANALYZE" != true ]]; then
        echo "🔎 Running static analysis..."
        fvm flutter analyze --fatal-infos
    fi

    if [[ "$SKIP_TEST" != true ]]; then
        echo "🧪 Running tests..."
        fvm flutter test --test-randomize-ordering-seed=random
    fi
}

parse_common_build_args() {
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
                SHOW_HELP=true
                shift
                ;;
            *)
                echo "Error: Unknown option: '$1'"
                SHOW_HELP=true
                shift
                ;;
        esac
    done
}
