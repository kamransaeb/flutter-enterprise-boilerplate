#!/bin/bash

# What each part means:
# fvm dart run build_runner --help
# tries to invoke build_runner from your project dependencies (through FVM SDK)
# --help makes it a lightweight command instead of running generation
# >/dev/null
# discard normal output
# 2>&1
# discard error output too
# success exit code is 0
# failure exit code is 1

# Code Generation Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🚀 Starting code generation..."

# Configuration
PROJECT_DIR=$(pwd)
# Modernized version of the build_runner command
BUILD_RUNNER="fvm dart run build_runner"
DELETE_CONFLICTING="--delete-conflicting-outputs"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_step() {
    echo -e "\n${YELLOW}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if build_runner is available
check_dependencies() {
    print_step "Checking dependencies..."
    
    # Optinal stronger follow-up check
    # if ! fvm flutter --version >/dev/null 2>&1; then
    #     print_error "FVM Flutter is not installed or not in PATH"
    #     exit 1
    # fi
    if ! command -v fvm &> /dev/null; then
        print_error "FVM Flutter is not installed or not in PATH"
        exit 1
    fi
   
    # Check if build_runner is installed globally
    # if ! fvm dart pub global list | grep -q "build_runner"; then
    #     print_step "Installing build_runner globally..."
    #     fvm dart pub global activate build_runner
    # fi
    # Replaced with a lightweight project level check
    # >/dev/null means suppress output
    # 2>&1 means redirect stderr to stdout
    # success exit code is 0
    # failure exit code is 1
    if ! fvm dart run build_runner --help >/dev/null 2>&1; then
        print_error "build_runner is not available. Add it to pubspec.yaml and run 'fvm flutter pub get'."
        exit 1
    fi
}

# Clean generated files
clean_generated() {
    print_step "Cleaning generated files..."
    
    # Remove generated files
    find . -name "*.g.dart" -type f -delete
    find . -name "*.gr.dart" -type f -delete
    find . -name "*.freezed.dart" -type f -delete
    find . -name "*.config.dart" -type f -delete
    
    # Remove build directory
    rm -rf build/
    
    print_success "Generated files cleaned"
}

# Generate Freezed classes
generate_freezed() {
    print_step "Generating Freezed classes..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING --config freezed
    
    # *** Because of set -e we don't need to check the exit code
    # if [ $? -eq 0 ]; then
    #     print_success "Freezed classes generated"
    # else
    #     print_error "Failed to generate Freezed classes"
    #     exit 1
    # fi
    print_success "Freezed classes generated"
}

# Generate JSON serialization
generate_json() {
    print_step "Generating JSON serialization..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING --config json
    
    print_success "JSON serialization generated"
}

# Generate Injectable configuration
generate_injectable() {
    print_step "Generating Injectable configuration..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING --config injectable
    
    print_success "Injectable configuration generated"
}

# Generate Retrofit clients
generate_retrofit() {
    print_step "Generating Retrofit clients..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING --config retrofit
    
    print_success "Retrofit clients generated"
}

# Generate AutoRoute configuration
generate_auto_route() {
    print_step "Generating AutoRoute configuration..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING --config auto_route

    print_success "AutoRoute configuration generated"
}

# Generate all code
generate_all() {
    print_step "Generating all code..."
    
    $BUILD_RUNNER build $DELETE_CONFLICTING
    print_success "All code generated successfully"
}

# Watch for changes
watch_changes() {
    print_step "Watching for changes..."
    
    $BUILD_RUNNER watch $DELETE_CONFLICTING
    
    print_success "Watching for changes"
}

# Generate icons
generate_icons() {
    print_step "Generating app icons..."
    require_dart_command "flutter_launcher_icons" "flutter_launcher_icons"
    if [ -f "flutter_launcher_icons.yaml" ]; then
        fvm dart run flutter_launcher_icons
        print_success "App icons generated"
    else
        print_error "flutter_launcher_icons.yaml not found"
    fi
}

# Generate splash screen
generate_splash() {
    print_step "Generating splash screen..."
    require_dart_command "flutter_native_splash:create" "flutter_native_splash"
    if [ -f "flutter_native_splash.yaml" ]; then
        fvm dart run flutter_native_splash:create
        print_success "Splash screen generated"
    else
        print_error "flutter_native_splash.yaml not found"
    fi
}

# Generate localization files
generate_localization() {
    print_step "Generating localization files..."
    
    if [ -f "l10n.yaml" ]; then
        fvm flutter gen-l10n
        print_success "Localization files generated"
    else
        print_error "l10n.yaml not found"
    fi
}

# Generate asset constants
generate_assets() {
    print_step "Generating asset constants..."
    
    if [ -f "flutter_gen.yaml" ]; then
        fvm dart run build_runner build --config flutter_gen
        print_success "Asset constants generated"
    else
        print_error "flutter_gen.yaml not found"
    fi
}

# Generate mocks for testing
generate_mocks() {
    print_step "Generating mocks for testing..."
    
    if [ -f "build.yaml" ]; then
        $BUILD_RUNNER build $DELETE_CONFLICTING --config mock
        print_success "Mocks generated"
    else
        print_error "build.yaml not found"
    fi
}

# Validate generated code
validate_generated() {
    print_step "Validating generated code..."
    
    # Check for any analysis issues
    fvm flutter analyze
    
    print_success "Generated code validated"
}

# Format generated code
format_generated() {
    print_step "Formatting generated code..."
    
    fvm dart format lib/
    print_success "Generated code formatted"
    
}

# Require dart command to be available
require_dart_command() {
    local package_cmd="$1"
    local package_name="$2"

    if ! fvm dart run "package_cmd" --help >/dev/null 2>&1; then
        print_error "$package_name is not available. Add it to pubspec.yaml and run 'fvm flutter pub get'."
        exit 1
    fi
    print_success "$package_name is available"
}

# Main execution
main() {
    local command=${1:-all}
    
    check_dependencies
    
    case $command in
        clean)
            clean_generated
            ;;
        freezed)
            generate_freezed
            ;;
        json)
            generate_json
            ;;
        injectable)
            generate_injectable
            ;;
        retrofit)
            generate_retrofit
            ;;
        auto_route)
            generate_auto_route
            ;;
        all)
            clean_generated
            generate_all
            validate_generated
            format_generated
            ;;
        watch)
            watch_changes
            ;;
        icons)
            generate_icons
            ;;
        splash)
            generate_splash
            ;;
        l10n)
            generate_localization
            ;;
        assets)
            generate_assets
            ;;
        mocks)
            generate_mocks
            ;;
        *)
            echo "Usage: $0 {clean|freezed|json|injectable|retrofit|auto_route|all|watch|icons|splash|l10n|assets|mocks}"
            exit 1
            ;;
    esac
    
    echo -e "\n${GREEN}🎉 Code generation completed successfully!${NC}"
}

# Run main function
main "$@"