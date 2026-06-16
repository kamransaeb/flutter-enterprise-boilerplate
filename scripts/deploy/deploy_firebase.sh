#!/bin/bash

# Firebase Deploy Script

set -e  # Exit on error
set -u  # Exit on undefined variable (prevents typos like $APPL_TEAM_ID)
set -o pipefail  # Exit on command failure in a pipeline

# Ensure script is run from project root
if [[ ! -f "pubspec.yaml" ]]; then
    echo "Error: This script must be run from the project root directory."
    exit 1
fi

echo "🔥 Deploying to Firebase..."

# Configuration it will exit with non zero code if FIREBASE_TOKEN is not set
PROJECT_ID="enterprise-app-12345"
: "${FIREBASE_TOKEN:?FIREBASE_TOKEN is required}"
FIREBASE_TOKEN=${FIREBASE_TOKEN}

# Check if firebase-tools is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ firebase-tools is not installed. Installing..."
    npm install -g firebase-tools
fi

# Login to Firebase (if not already logged in)
if ! firebase projects:list 2>/dev/null | grep -q "$PROJECT_ID"; then
    echo "🔐 Logging into Firebase..."
    firebase login --no-localhost
fi

# Set project
echo "🎯 Setting Firebase project..."
firebase use $PROJECT_ID

# Build web
echo "🌐 Building web version..."
flutter build web --release

# Deploy to Firebase Hosting
echo "🚀 Deploying to Firebase Hosting..."
firebase deploy --only hosting --message "Release $(date +%Y%m%d-%H%M%S)"

# Deploy to Firebase Functions (if any)
if [ -d "functions" ]; then
    echo "⚡ Deploying Firebase Functions..."
    cd functions
    npm install
    firebase deploy --only functions
    cd ..
fi

# Deploy Firestore rules (if any)
if [ -f "firestore.rules" ]; then
    echo "📝 Deploying Firestore rules..."
    firebase deploy --only firestore:rules
fi

# Deploy Storage rules (if any)
if [ -f "storage.rules" ]; then
    echo "💾 Deploying Storage rules..."
    firebase deploy --only storage:rules
fi

echo "✅ Firebase deployment completed!"
echo "🌍 App URL: https://$PROJECT_ID.web.app"