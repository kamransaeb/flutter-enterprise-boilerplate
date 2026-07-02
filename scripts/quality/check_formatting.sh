#!/bin/bash

# Formatting check script
# Practical baseline without extra lint dependencies.

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🎨 Checking code formatting..."

# Check formatting without modifying files.
fvm dart format --set-exit-if-changed .

echo "✅ Formatting check completed!"
