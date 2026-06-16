#!/bin/bash
# Run the app

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🚀 Running the app..."

FLAVOR="dev"
TARGET=""
DEVICE=""
RUN_CODEGEN=false
POD_INSTALL=false
EXTRA_ARGS=()

usage() {
    cat <<'EOF'
Usage: ./scripts/run/run_app.sh [options]

Options:
  -f, --flavor <dev|staging|prod>    Build flavor (dev, staging, prod) [default: dev]
  -t, --target <path>                Entry point path (e.g. lib/main.dart) [default: lib/main.dart]
  -d, --device <id>                  Device ID (see: fvm flutter devices)
  -c, --codegen                      Run build_runner before launching [default: false]
  -p, --pod-install                  Install pod [default: false]
  -l, --list-devices                 List available devices
  -h, --help                         Show this help message

  Examples:
  ./scripts/run/run_app.sh
  ./scripts/run/run_app.sh -f dev -d chrome
  ./scripts/run/run_app.sh -f staging -d 00008120-001670900A33401E
  ./scripts/run/run_app.sh -f dev -c -p
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
        -d|--device)
            DEVICE="$2"
            shift 2
            ;;
        -c|--codegen)
            RUN_CODEGEN=true
            shift
            ;;
        -p|--pod-install)
            POD_INSTALL=true
            shift
            ;;
        -l|--list-devices)
            fvm flutter devices            
            exit 0
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            EXTRA_ARGS+=("$@")
            break
            ;;
        *)
            EXTRA_ARGS+=("$1")
            shift            
            ;;
    esac
done

case $FLAVOR in
    dev|staging|prod)
        ;;
    *)
        echo "Error: Invalid flavor: '$FLAVOR'. Use dev, staging, or prod."
        usage
        exit 1
        ;;
esac

if [[ -z "$TARGET" ]]; then
    TARGET="lib/main_${FLAVOR}.dart"
fi

if [[ ! -f "$TARGET" ]]; then
    echo "Error: Target file not found: '$TARGET'"
    usage
    exit 1
fi

ENV_FILE=".env.${FLAVOR}"
if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: Environment file not found: '$ENV_FILE'"
    usage
    exit 1
fi

echo "✅ Configuration complete!"
echo "🔍 Running the app..."
echo "🔍 Using flavor: '$FLAVOR'"
echo "🔍 Using environment file: '$ENV_FILE'"
echo "🔍 Using target file: '$TARGET'"
echo "🔍 Using device: '$DEVICE'"
if [[ ${#EXTRA_ARGS[@]} -gt 0 ]]; then
    echo "🔍 Using extra arguments: '${EXTRA_ARGS[*]}'"
else
    echo "🔍 No extra arguments provided"
fi

fvm flutter pub get

if [[ "$RUN_CODEGEN" == true ]]; then
    echo "🔍 Running code generation..."
    fvm dart run build_runner build --delete-conflicting-outputs
fi

if [[ "$POD_INSTALL" == true ]]; then
    echo "🔍 Installing pod..."
    (cd ios && pod install)
fi

CMD=(fvm flutter run --flavor "$FLAVOR" -t "$TARGET")

if [[ -n "$DEVICE" ]]; then
    CMD+=(-d "$DEVICE")
fi

if [[ ${#EXTRA_ARGS[@]} -gt 0 ]]; then
    CMD+=("${EXTRA_ARGS[@]}")
fi

echo "🔍 Running command: '${CMD[*]}'"
exec "${CMD[@]}"