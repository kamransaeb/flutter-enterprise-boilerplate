# Flutter Enterprise Boilerplate

A production-ready Flutter application following **Clean Architecture**, feature-based modules, and **Very Good Analysis** conventions.

## Features

- **Clean Architecture** — `domain` / `data` / `presentation` per feature
- **Multi-flavor** — `dev`, `staging`, `prod` with separate entry points and env files
- **State management** — `flutter_bloc` + Freezed 3 unions
- **Dependency injection** — GetIt + Injectable
- **Networking** — Dio + Retrofit (`ApiClient`) + interceptors (auth, cache, retry, logging)
- **Navigation** — AutoRoute (`lib/core/navigation/app_router.dart`)
- **Local storage** — Hive + Secure Storage
- **Firebase** — Analytics, Crashlytics, Messaging, Remote Config (per-flavor options)
- **Monitoring** — Sentry
- **Localization** — easy_localization (`assets/translations/`)
- **CI/CD** — GitHub Actions (`.github/workflows/`)

## Prerequisites

- [FVM](https://fvm.app/) (project uses `fvm flutter` / `fvm dart`)
- Flutter SDK (compatible with Dart `^3.10.3` — see `pubspec.yaml`)
- Xcode (iOS), Android Studio / SDK (Android)

## Getting Started

### 1. Install dependencies

```bash
fvm flutter pub get
```

### 2. Environment files

Copy the example and create per-flavor env files (required by `run_app.sh`):

```bash
cp .env.example .env.dev
cp .env.example .env.staging
cp .env.example .env.prod
```

Edit values per environment (`API_BASE_URL`, `SENTRY_DSN`, Firebase keys, etc.).

### 3. Code generation

Generates Freezed, Injectable, Retrofit (`api_client.g.dart`), AutoRoute (`app_router.gr.dart`), and JSON serializers:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

Or use the script:

```bash
./scripts/codegen/generate_code.sh
```

**Note:** `build.yaml` scopes Retrofit and AutoRoute to specific paths. Ensure `lib/infrastructure/network/client/api_client.dart` is included in Retrofit `generate_for` if `api_client.g.dart` is missing.

### 4. iOS pods (first run / after dependency changes)

```bash
cd ios && pod install && cd ..
```

## Running the App

### Recommended — `run_app.sh`

```bash
# Dev (default)
./scripts/run/run_app.sh

# Staging / prod
./scripts/run/run_app.sh -f staging
./scripts/run/run_app.sh -f prod

# Specific device
./scripts/run/run_app.sh -f dev -d <device-id>

# List devices
./scripts/run/run_app.sh -l

# Run codegen + pod install before launch
./scripts/run/run_app.sh -f dev -c -p

# Release mode (pass through to flutter run)
./scripts/run/run_app.sh -f dev -- --release
```

### Manual `flutter run`

```bash
fvm flutter run --flavor dev -t lib/main_dev.dart
fvm flutter run --flavor staging -t lib/main_staging.dart
fvm flutter run --flavor prod -t lib/main_prod.dart
```

## Flavors

| Flavor    | Entry point             | Env file       | Android suffix | iOS scheme |
|-----------|-------------------------|----------------|----------------|------------|
| `dev`     | `lib/main_dev.dart`     | `.env.dev`     | `.dev`         | `dev`      |
| `staging` | `lib/main_staging.dart` | `.env.staging` | `.staging`     | `staging`  |
| `prod`    | `lib/main_prod.dart`    | `.env.prod`    | (none)         | `prod`     |

Bootstrap loads env via `Bootstrap.initialize(flavor:, envPath:)` in each `main_*.dart`.

## Building

### Android

```bash
fvm flutter build apk --flavor dev -t lib/main_dev.dart
fvm flutter build appbundle --flavor prod -t lib/main_prod.dart
```

Full pipeline (clean, codegen, analyze, test, build):

```bash
./scripts/build/build_android.sh -f prod
# APK only
./scripts/build/build_android.sh -f staging --apk-only
# Skip long preflight stages
./scripts/build/build_android.sh -f dev --skip-test --skip-analyze
```

### iOS

```bash
fvm flutter build ios --flavor dev -t lib/main_dev.dart --no-codesign
```

Archive in Xcode using scheme **`dev`**, **`staging`**, or **`prod`**.

```bash
# Build without signing/export
./scripts/build/build_ios.sh -f prod

# Build + archive + export IPA
APPLE_TEAM_ID=XXXXXXXXXX ./scripts/build/build_ios.sh -f prod --archive
```

### Other platforms

```bash
./scripts/build/build_web.sh -f staging
./scripts/build/build_macos.sh -f prod
./scripts/build/build_windows.sh -f prod
```

## Deployment

### Firebase / Hosting

```bash
# Hosting only (default)
./scripts/deploy/deploy_firebase.sh -f staging

# Hosting + functions + rules
./scripts/deploy/deploy_firebase.sh -f prod --all

# Web convenience wrapper
./scripts/deploy/deploy_web.sh -f prod
```

Environment:

- `FIREBASE_TOKEN` for CI/non-interactive deployments
- `FIREBASE_PROJECT_ID` (optional override)

### Google Play

```bash
# Build app bundle only
./scripts/deploy/deploy_playstore.sh -f prod

# Build + upload to Play internal track
SUPPLY_JSON_KEY=/path/key.json \
SUPPLY_PACKAGE_NAME=com.example.app \
./scripts/deploy/deploy_playstore.sh -f prod --upload --track internal
```

### App Store Connect

```bash
# Build/archive IPA only
APPLE_TEAM_ID=XXXXXXXXXX \
./scripts/deploy/deploy_appstore.sh -f prod

# Upload existing IPA
APP_STORE_CONNECT_API_KEY_PATH=/path/AuthKey_ABC123XYZ.p8 \
APP_STORE_CONNECT_API_KEY_ID=ABC123XYZ \
APP_STORE_CONNECT_ISSUER_ID=00000000-0000-0000-0000-000000000000 \
./scripts/deploy/deploy_appstore.sh --no-build --artifact build/ios/ipa/prod/Runner.ipa --upload
```

## Scripts Reference

```
scripts/
├── run/
│   └── run_app.sh              # Run app (dev/staging/prod)
├── build/
│   ├── build_android.sh
│   ├── build_ios.sh
│   ├── build_web.sh
│   ├── build_macos.sh
│   └── build_windows.sh
├── codegen/
│   ├── generate_code.sh        # build_runner (Freezed, Injectable, Retrofit, AutoRoute)
│   ├── generate_icons.sh
│   ├── generate_splash.sh
│   └── generate_localizations.sh
├── quality/
│   ├── analyze_code.sh
│   ├── run_lint.sh
│   ├── check_formatting.sh
│   ├── run_tests.sh
│   └── generate_coverage.sh
├── deploy/
│   ├── deploy_playstore.sh
│   ├── deploy_appstore.sh
│   ├── deploy_firebase.sh
│   └── deploy_web.sh
├── ci/
│   ├── setup_environment.sh
│   └── prepare_build.sh
└── tools/
    ├── clean_project.sh
    ├── check_health.sh
    └── update_dependencies.sh
```

## Testing

```bash
fvm flutter test
fvm flutter test --coverage
fvm flutter test integration_test
./scripts/quality/run_tests.sh
```

## Code Generation

```bash
# Generate all code
fvm dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
fvm dart run build_runner watch --delete-conflicting-outputs
```

## Project Structure

```
lib/
├── main.dart                 # Default entry (prod-oriented)
├── main_dev.dart             # Dev entry
├── main_staging.dart         # Staging entry
├── main_prod.dart            # Production entry
├── bootstrap/                # App bootstrap & performance
├── app/                      # App widget, config, initializer
├── core/                     # Navigation, themes, errors, blocs, widgets
├── features/                 # Feature modules (auth, products, order, …)
│   └── <feature>/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── infrastructure/           # DI, network, cache, storage, services

assets/
├── translations/             # easy_localization JSON files
├── images/
├── animations/
└── fonts/

scripts/                      # Build, run, codegen, CI helpers
.github/workflows/            # CI/CD pipelines
```

### Feature modules

`auth`, `dashboard`, `notification`, `order`, `payments`, `products`, `profile`, `settings`, `splash`, `sync`

## Architecture Notes

- **Repositories** map `ApiResponse` / cache ↔ domain entities (`Either<Failure, T>`).
- **Auth** — prefer `AuthInterceptor` for `Authorization: Bearer …`; use `@Extra({'requireAuth': false})` on public Retrofit endpoints (login, register).
- **Codegen** — after changing Freezed models, Injectable classes, `api_client.dart`, or routes, re-run `build_runner`.

## Environment Variables

Per-flavor env files (`.env.dev`, `.env.staging`, `.env.prod`) are loaded at startup. See `.env.example` for available keys:

- `API_BASE_URL`, `API_*_TIMEOUT`
- `SENTRY_DSN`, `SENTRY_ENVIRONMENT`
- Firebase configuration
- Feature flags (`FEATURE_ANALYTICS`, `FEATURE_CRASH_REPORTING`, etc.)

In CI/CD, set these as GitHub Secrets for production builds.

## CI/CD

Workflows in `.github/workflows/`:

- `ci.yml` — analyze, test, Android/iOS builds
- `cd.yml`, `release.yml`, `nightly.yml`, `codeql-analysis.yml`

## Contributing

1. Follow existing Clean Architecture and bloc/Freezed patterns
2. Run `fvm flutter analyze`
3. Run tests before opening a PR
4. Regenerate code when changing annotated classes
5. Update this README when adding scripts, flavors, or tooling
