# Yoga Sala Plus Mobile — Complete Step-by-Step Tutorial

Full record of what we did for **`yogasala_plus_mobile`**, step by step, with the same detail as the working sessions (including decisions, pasteable code, and problems we hit).

| Item | Value |
|------|--------|
| App path | `/Users/kamransaeb/Workspace/enginar_teklonoji/yogasala_plus/yogasala_plus_mobile` |
| Packages monorepo | `flutter_enterprise_packages` (git deps, e.g. `ref: v0.1.1`) |
| Reference boilerplate | This repo: `flutter_enterprise_boilerplate` |
| Working style | One step at a time; reply **proceed** between steps |
| Done so far | Flavors (dev/staging/prod) + Firebase + Email/Password auth + navigation |
| Not done yet | Fastlane, GitHub Actions CI/CD |

---

## Table of contents

1. [Roadmap overview](#1-roadmap-overview)
2. [Locked architecture decisions](#2-locked-architecture-decisions)
3. [Step 1 — Firebase projects & apps](#3-step-1--firebase-projects--apps)
4. [Step 1.2 — CLI tooling](#4-step-12--cli-tooling)
5. [Step 1.3–1.4 — Dependencies & FlutterFire](#5-step-13–14--dependencies--flutterfire)
6. [Step 1.5 — Env files](#6-step-15--env-files)
7. [Step 2.1 — Android flavors](#7-step-21--android-flavors)
8. [Step 2.2 — iOS flavors (detailed)](#8-step-22--ios-flavors-detailed)
9. [Step 2.3 — AppConfig, Bootstrap, entrypoints](#9-step-23--appconfig-bootstrap-entrypoints)
10. [Step 3 — Firebase Authentication](#10-step-3--firebase-authentication)
11. [Navigation & AuthGuard (best practice)](#11-navigation--authguard-best-practice)
12. [Logout](#12-logout)
13. [How to run](#13-how-to-run)
14. [Master checklist](#14-master-checklist)
15. [What’s next (Fastlane / CI/CD)](#15-whats-next-fastlane--cicd)
16. [Troubleshooting encyclopedia](#16-troubleshooting-encyclopedia)

---

## 1. Roadmap overview

Original plan we locked:

```text
Phase 1  Firebase + flavors base
Phase 2  Firebase Auth in the app
Phase 3  Fastlane (pending)
Phase 4  GitHub Actions CI/CD (pending)
```

| Step | Topic |
|------|--------|
| **1** | Firebase projects + FlutterFire |
| **2** | Flutter flavors (Android/iOS) + `AppConfig` + `main_*.dart` |
| **3** | Firebase Authentication in auth layer |
| **4** | Fastlane (Supply + TestFlight) — **not started** |
| **5** | GitHub Actions CI — **not started** |
| **6** | GitHub Actions CD + secrets — **not started** |

---

## 2. Locked architecture decisions

| Topic | Decision |
|-------|----------|
| Shared packages | No GetIt/Injectable, no `AppConfig`, no Firebase inside packages |
| DI / features / AutoRoute / auth | Live **only in client apps** |
| Auth package | **No** `enterprise_auth` — auth stays in the app |
| External package consume | Pin **git tags** (e.g. `v0.1.1`), not `main`; release branches without `resolution: workspace` |
| Local override | Optional `pubspec_overrides.yaml` with path deps (gitignored) |
| `LoginBloc` | Page-scoped via `BlocProvider(create: (_) => LoginBloc())`, not GetIt |
| `LoginForm` | **StatefulWidget** + controllers; `LoginPage` Stateless |
| Form reset on API failure | `LoginEvent.authFailed()` — reset status only, keep field text |
| Package IDs | Short: `com.yogasala.plus.mobile` + `.dev` / `.staging` |
| Side-by-side installs | Yes — different `applicationId` / bundle ID per flavor |

**Original Android id before shorten:**  
`com.yogasala.plus.mobile.yogasala_plus_mobile` → replaced by short base.

---

## 3. Step 1 — Firebase projects & apps

### 3.1 Create three Firebase projects

In [Firebase Console](https://console.firebase.google.com/):

| Environment | Suggested project ID | Purpose |
|-------------|----------------------|---------|
| **dev** | `yogasala-plus-dev` | Local + debug |
| **staging** | `yogasala-plus-staging` | QA / internal testers |
| **prod** | `yogasala-plus-prod` | Live users |

### 3.2 How package names work (Android)

Firebase’s Android **package name must match the final `applicationId` of that build**, not only Gradle `namespace`.

**Recommended (side-by-side installs)** — what we locked:

| Flavor | Gradle | Final package name in Firebase |
|--------|--------|--------------------------------|
| **prod** | no suffix | `com.yogasala.plus.mobile` |
| **staging** | `applicationIdSuffix = ".staging"` | `com.yogasala.plus.mobile.staging` |
| **dev** | `applicationIdSuffix = ".dev"` | `com.yogasala.plus.mobile.dev` |

In Firebase Console for each project:

1. Add app → **Android**
2. Paste the **full** package name for that env
3. Nickname optional (`YogaSala Plus Dev`, etc.)
4. SHA-1 only needed later for Google Sign-In / Phone Auth — skip for Email/Password

**Do not** invent a shorter name like `com.yogasala.plus` unless Gradle `applicationId` matches.

**Alternative we rejected:** same package name for all envs (no suffix) → cannot install two flavors on one device.

**Boilerplate note:** this boilerplate uses `.dev` / `.staging` suffixes in Gradle, but some `google-services.json` files listed the **same** unsuffixed package — a mismatch. For YogaSala we registered the **suffixed** names correctly.

### 3.3 Add iOS apps

Same short IDs as Android. Xcode originally had  
`com.yogasala.plus.mobile.yogasalaPlusMobile` — changed later to short IDs.

| Flavor | iOS bundle ID |
|--------|----------------|
| **prod** | `com.yogasala.plus.mobile` |
| **staging** | `com.yogasala.plus.mobile.staging` |
| **dev** | `com.yogasala.plus.mobile.dev` |

For each Firebase project: Add app → iOS → exact bundle ID → skip App Store ID and downloading plist for now (FlutterFire / manual copy later).

### 3.4 Enable Email/Password (1.1b)

In **each** of the three projects:

1. **Build → Authentication → Get started** (if first time)
2. **Sign-in method → Email/Password → Enable → Save**
3. Leave **Email link** off for now

Later: **Authentication → Users → Add user** for a test account on **dev** (e.g. `test@yogasala.dev`).

---

## 4. Step 1.2 — CLI tooling

```bash
# Firebase CLI
npm install -g firebase-tools
firebase login

# FlutterFire CLI
dart pub global activate flutterfire_cli
```

Ensure PATH (zsh):

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Verify:

```bash
firebase --version
flutterfire --version
```

---

## 5. Step 1.3–1.4 — Dependencies & FlutterFire

### 5.1 Dependencies

In `yogasala_plus_mobile/pubspec.yaml` (already present when we checked):

```yaml
dependencies:
  firebase_core: ^4.14.0   # versions may differ slightly
  firebase_auth: ^6.6.1
  flutter_dotenv: ^6.0.1
```

```bash
cd /Users/kamransaeb/Workspace/enginar_teklonoji/yogasala_plus/yogasala_plus_mobile
flutter pub get
```

### 5.2 Generate Firebase options (once per env)

```bash
# DEV
flutterfire configure \
  --project=yogasala-plus-dev \
  --out=lib/firebase_options_dev.dart \
  --platforms=android,ios \
  --android-package-name=com.yogasala.plus.mobile.dev \
  --ios-bundle-id=com.yogasala.plus.mobile.dev \
  --yes

# STAGING
flutterfire configure \
  --project=yogasala-plus-staging \
  --out=lib/firebase_options_staging.dart \
  --platforms=android,ios \
  --android-package-name=com.yogasala.plus.mobile.staging \
  --ios-bundle-id=com.yogasala.plus.mobile.staging \
  --yes

# PROD
flutterfire configure \
  --project=yogasala-plus-prod \
  --out=lib/firebase_options_prod.dart \
  --platforms=android,ios \
  --android-package-name=com.yogasala.plus.mobile \
  --ios-bundle-id=com.yogasala.plus.mobile \
  --yes
```

You should get:

- `lib/firebase_options_dev.dart`
- `lib/firebase_options_staging.dart`
- `lib/firebase_options_prod.dart`

### 5.3 Critical: FlutterFire overwrites native config files

Each `flutterfire configure` writes to the **same** paths:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

and **overwrites** the previous run. Last run (prod) leaves only prod in those default paths.

**What to do:** use Console downloads (or copy after each `flutterfire` run) into flavor folders:

| File | Must contain |
|------|----------------|
| `android/app/src/dev/google-services.json` | `project_id: yogasala-plus-dev` + `package_name: …mobile.dev` |
| `android/app/src/staging/google-services.json` | staging + `…mobile.staging` |
| `android/app/src/prod/google-services.json` | prod + `…mobile` |

Open each JSON and confirm `project_id` and `package_name`. **Don’t** copy the prod file into dev/staging.

Dart `firebase_options_*.dart` files are already per-flavor; native Android still needs the three JSONs.

---

## 6. Step 1.5 — Env files

### What is dotenv?

**dotenv** loads key/value settings from a text file into the app at startup.

Instead of hardcoding:

```dart
baseUrl: 'https://api-dev.yogasala.com'
```

you put:

```env
APP_NAME=Yoga Sala Plus DEV
API_BASE_URL=https://jsonplaceholder.typicode.com
ENABLE_LOGGING=true
```

Then:

```dart
await dotenv.load(fileName: '.env.dev');
final url = dotenv.env['API_BASE_URL'];
```

| Flavor | File |
|--------|------|
| dev | `.env.dev` |
| staging | `.env.staging` |
| prod | `.env.prod` |

**Notes:**

- List files under `flutter: assets:` in `pubspec.yaml`
- Don’t put real secrets in committed env files if the repo is public
- Until a real API exists, keep posts working with jsonplaceholder as `API_BASE_URL`

Example asset registration:

```yaml
flutter:
  assets:
    - assets/translations/
    - .env.dev
    - .env.staging
    - .env.prod
```

---

## 7. Step 2.1 — Android flavors

### 7.1 productFlavors

In `android/app/build.gradle.kts`:

```kotlin
defaultConfig {
    applicationId = "com.yogasala.plus.mobile"
    // keep minSdk / targetSdk / etc.
}

flavorDimensions += "env"
productFlavors {
    create("dev") {
        dimension = "env"
        applicationIdSuffix = ".dev"
        versionNameSuffix = "-dev"
        resValue("string", "app_name", "Yoga Sala Plus [DEV]")
    }
    create("staging") {
        dimension = "env"
        applicationIdSuffix = ".staging"
        versionNameSuffix = "-staging"
        resValue("string", "app_name", "Yoga Sala Plus [STG]")
    }
    create("prod") {
        dimension = "env"
        resValue("string", "app_name", "Yoga Sala Plus")
    }
}
```

### 7.2 Google Services plugin (confirm)

Already wired in YogaSala (same pattern as boilerplate):

**`android/settings.gradle.kts`**

```kotlin
id("com.google.gms.google-services") version("4.4.4") apply false
```

**`android/app/build.gradle.kts`**

```kotlin
id("com.google.gms.google-services")
```

(Boilerplate used `4.3.15`; newer is fine.)

### 7.3 Verify later (after Dart entrypoints exist)

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

Do **not** run this before `main_dev.dart` exists — `-t` will fail with target not found.

---

## 8. Step 2.2 — iOS flavors (detailed)

### 8.1 Target layout (boilerplate pattern)

```text
ios/
  Dev.xcconfig / Staging.xcconfig / Prod.xcconfig     ← flavor settings
  Debug-dev.xcconfig / Release-dev.xcconfig / ...     ← Pods + flavor (9 files)
  Flutter/
    Debug.xcconfig / Release.xcconfig [/ Profile.xcconfig]
    Generated.xcconfig
  config/
    dev/GoogleService-Info.plist
    staging/GoogleService-Info.plist
    prod/GoogleService-Info.plist
  schemes: dev / staging / prod
```

Chain:

```text
flutter run --flavor dev
  → Scheme "dev" → build config "Debug-dev"
  → Debug-dev.xcconfig
       ├── 1) Pods-Runner.debug-dev.xcconfig   ← CocoaPods / plugins
       └── 2) Dev.xcconfig
                ├── Flutter/Generated.xcconfig
                ├── PRODUCT_BUNDLE_IDENTIFIER
                ├── APP_NAME
                └── FLUTTER_TARGET=lib/main_dev.dart
```

### 8.2 Why three layers?

| Layer | Example | Job |
|-------|---------|-----|
| Mode + flavor | `Debug-dev.xcconfig` | Glue: Pods for that build type + flavor |
| Flavor only | `Dev.xcconfig` | Identity: bundle id, name, Dart target |
| Generated | `Flutter/Generated.xcconfig` | Flutter SDK paths (do not edit) |

Debug vs Release need different Pods settings → 9 mode+flavor files, not one per flavor.

### 8.3 What is `#include` vs `#include?`

```xcconfig
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Generated.xcconfig"
```

| Syntax | Missing file |
|--------|----------------|
| `#include "..."` | Build **error** |
| `#include? "..."` | Silently **skipped** |

Flutter uses `#include?` for Pods so a fresh clone can open before `pod install`. Flavor mode files use plain `#include` (Pods expected to exist).

### 8.4 Podfile missing (Flutter 3.44)

`flutter create . --platforms=ios` **skips** an existing `ios/` folder, and newer Flutter app templates often **don’t ship a Podfile** (Swift Package Manager path).

**Fix:** copy the template:

```bash
cp "$(dirname $(which flutter))/../packages/flutter_tools/templates/cocoapods/Podfile-ios" ios/Podfile
# or with FVM:
# cp /Users/kamransaeb/fvm/versions/3.44.8/packages/flutter_tools/templates/cocoapods/Podfile-ios ios/Podfile
```

Set platform:

```ruby
platform :ios, '15.0'
```

Use **`15.0`** (same as boilerplate). `15.0` vs `15.1` does not matter here. Xcode may show some configs at `15.6` — fine; Podfile `15.0` is a minimum.

Then:

```bash
flutter pub get
cd ios && pod install
```

Optional if plugins don’t resolve:

```bash
flutter config --no-enable-swift-package-manager
flutter clean && flutter pub get
cd ios && pod install
```

### 8.5 CocoaPods “base configuration” warnings

If flavor configs point at bare `Dev.xcconfig` (no Pods include), CocoaPods warns that it cannot set base config.

**Correct:** Xcode **Based on Configuration File** for Runner must be `Debug-dev` / `Release-dev` / etc., **not** bare `Dev` / `Staging` / `Prod`, and **not** `Pods-Runner.debug-dev` alone.

If CocoaPods/Xcode sets base **to** Pods directly, `Dev.xcconfig` never loads → empty bundle id.

Build Settings often has:

```text
PRODUCT_BUNDLE_IDENTIFIER = $(PRODUCT_BUNDLE_IDENTIFIER)
```

That only works if the xcconfig chain actually defines `PRODUCT_BUNDLE_IDENTIFIER`. Otherwise:

> Bundle identifier is missing. Runner doesn't have a bundle identifier.

**Fix:** point each flavor config at the matching mode+flavor file.

### 8.6 Flavor xcconfigs (root) — exact content

**`ios/Dev.xcconfig`**

```xcconfig
#include "Flutter/Generated.xcconfig"

PRODUCT_BUNDLE_IDENTIFIER=com.yogasala.plus.mobile.dev
APP_NAME=Yoga Sala Plus [DEV]
FLUTTER_TARGET=lib/main_dev.dart
APP_ICON_NAME=AppIcon
```

**`ios/Staging.xcconfig`**

```xcconfig
#include "Flutter/Generated.xcconfig"

PRODUCT_BUNDLE_IDENTIFIER=com.yogasala.plus.mobile.staging
APP_NAME=Yoga Sala Plus [STG]
FLUTTER_TARGET=lib/main_staging.dart
APP_ICON_NAME=AppIcon
```

**`ios/Prod.xcconfig`**

```xcconfig
#include "Flutter/Generated.xcconfig"

PRODUCT_BUNDLE_IDENTIFIER=com.yogasala.plus.mobile
APP_NAME=Yoga Sala Plus
FLUTTER_TARGET=lib/main_prod.dart
APP_ICON_NAME=AppIcon
```

### 8.7 Remove duplicate Flutter/ flavor files

Xcode uses **`ios/` root** files. Delete duplicates:

```text
DELETE: ios/Flutter/Dev.xcconfig
DELETE: ios/Flutter/Staging.xcconfig
DELETE: ios/Flutter/Prod.xcconfig
```

**Keep:**

```text
ios/Flutter/Debug.xcconfig
ios/Flutter/Release.xcconfig
ios/Flutter/Generated.xcconfig
```

### 8.8 The 9 mode+flavor files

Use **lowercase** Pods names (what CocoaPods generated for YogaSala):

**`ios/Debug-dev.xcconfig`**

```xcconfig
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug-dev.xcconfig"
#include "Dev.xcconfig"
```

**`ios/Release-dev.xcconfig`**

```xcconfig
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.release-dev.xcconfig"
#include "Dev.xcconfig"
```

**`ios/Profile-dev.xcconfig`**

```xcconfig
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile-dev.xcconfig"
#include "Dev.xcconfig"
```

Same for staging (`debug-staging` + `Staging.xcconfig`) and prod (`debug-prod` + `Prod.xcconfig`).

**`ios/Flutter/Debug.xcconfig`**

```xcconfig
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
#include "Generated.xcconfig"
```

**`ios/Flutter/Release.xcconfig`**

```xcconfig
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Generated.xcconfig"
```

### 8.9 Default Profile warning (optional)

Plain `Profile` often points at `Flutter/Release.xcconfig`, but CocoaPods wants `Pods-Runner.profile.xcconfig`.

Optional fix — create `ios/Flutter/Profile.xcconfig`:

```xcconfig
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig"
#include "Generated.xcconfig"
```

Point plain Profile → `Flutter/Profile`.

**Xcode “Add Files” trap:** even with “Copy items” unchecked, File → New or bad Add Files can duplicate into `ios/` root. Prefer creating the file on disk with an editor/terminal; or **ignore** this one warning — flavor `Profile-dev` etc. already include the right Pods files.

### 8.10 Schemes (2.2.5)

Only `Runner.xcscheme` existed initially. Create shared schemes named exactly **`dev`**, **`staging`**, **`prod`**.

In Xcode: Product → Scheme → Manage Schemes → Duplicate Runner → rename → check **Shared**.

| Action | `dev` | `staging` | `prod` |
|--------|-------|-----------|--------|
| Run / Test / Analyze | Debug-dev | Debug-staging | Debug-prod |
| Profile | Profile-dev | Profile-staging | Profile-prod |
| Archive | Release-dev | Release-staging | Release-prod |

On disk:

```text
ios/Runner.xcodeproj/xcshareddata/xcschemes/dev.xcscheme
ios/Runner.xcodeproj/xcshareddata/xcschemes/staging.xcscheme
ios/Runner.xcodeproj/xcshareddata/xcschemes/prod.xcscheme
```

### 8.11 GoogleService-Info per flavor + copy script (2.2.6)

Place sources (same filename in each folder):

```text
ios/config/dev/GoogleService-Info.plist
ios/config/staging/GoogleService-Info.plist
ios/config/prod/GoogleService-Info.plist
```

Verify content:

| Folder | `BUNDLE_ID` | `PROJECT_ID` |
|--------|-------------|--------------|
| `dev/` | `com.yogasala.plus.mobile.dev` | `yogasala-plus-dev` |
| `staging/` | `…mobile.staging` | `yogasala-plus-staging` |
| `prod/` | `…mobile` | `yogasala-plus-prod` |

**Copy Bundle Resources:** keep **one** entry — `Runner/GoogleService-Info.plist`.  
Do **not** add the three `config/` plists as resources (name conflict).

How it works:

```text
config/dev/...    ─┐
config/staging/...├── Run Script copies ONE → Runner/GoogleService-Info.plist
config/prod/...   ─┘                              ↓
                                   Copy Bundle Resources → into .app
```

If you removed it from Copy Bundle Resources by mistake, add `Runner/GoogleService-Info.plist` back.

**Build Phases location:** select **TARGETS → Runner** (not PROJECT). Tabs include Build Phases.

**Run Script** (name e.g. `Copy GoogleService-Info` / `My Copy GoogleService-Info`), above Compile Sources / Copy Bundle Resources; uncheck “Based on dependency analysis”:

```bash
#!/bin/bash
set -euo pipefail

case "${CONFIGURATION}" in
  *-dev)      FLAVOR=dev ;;
  *-staging)  FLAVOR=staging ;;
  *-prod)     FLAVOR=prod ;;
  *)          FLAVOR=prod ;;
esac

SRC="${PROJECT_DIR}/config/${FLAVOR}/GoogleService-Info.plist"
DST="${PROJECT_DIR}/Runner/GoogleService-Info.plist"

echo "CONFIGURATION=${CONFIGURATION}"
echo "Copying GoogleService-Info.plist for flavor: ${FLAVOR}"
echo "SRC=${SRC}"

if [[ ! -f "${SRC}" ]]; then
  echo "error: Missing ${SRC}"
  exit 1
fi

cp "${SRC}" "${DST}"
echo "Copied GoogleService-Info.plist for flavor: ${FLAVOR}"
```

**Where the log appears:** Xcode Report navigator → build → expand the script phase. Flutter console often **hides** it.

Verify after a **dev** build:

```bash
/usr/libexec/PlistBuddy -c 'Print :PROJECT_ID' ios/Runner/GoogleService-Info.plist
# expect: yogasala-plus-dev
```

### 8.12 “[DEFAULT]” Firebase vs “default env”

`[DEFAULT]` is only the Firebase **app name**, not “open prod.”

You still want **one** Firebase app per process, matching the **flavor** (plist + `firebase_options_*.dart`).

- Always pass `options:` from `AppConfig`
- Always run with `--flavor` and `-t`
- Use `if (Firebase.apps.isEmpty)` so native auto-init from plist doesn’t create a second app

---

## 9. Step 2.3 — AppConfig, Bootstrap, entrypoints

### 9.1 `lib/app/app_config.dart` (slim)

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yogasala_plus_mobile/firebase_options_dev.dart' as dev;
import 'package:yogasala_plus_mobile/firebase_options_staging.dart' as staging;
import 'package:yogasala_plus_mobile/firebase_options_prod.dart' as prod;

enum Flavor { dev, staging, prod }

class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.firebaseOptions,
  });

  final Flavor flavor;
  final String appName;
  final String apiBaseUrl;
  final bool enableLogging;
  final FirebaseOptions firebaseOptions;

  factory AppConfig.fromEnv(Flavor flavor) {
    return AppConfig(
      flavor: flavor,
      appName: dotenv.env['APP_NAME'] ?? 'Yoga Sala Plus',
      apiBaseUrl: dotenv.env['API_BASE_URL'] ?? '',
      enableLogging: dotenv.env['ENABLE_LOGGING']?.toLowerCase() == 'true',
      firebaseOptions: _firebaseOptions(flavor),
    );
  }

  static FirebaseOptions _firebaseOptions(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.staging:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }

  bool get isDev => flavor == Flavor.dev;
  bool get isStaging => flavor == Flavor.staging;
  bool get isProd => flavor == Flavor.prod;
}
```

(We kept this slim — not the full boilerplate `AppConfig` with Sentry/cache.)

### 9.2 Entrypoints

**`lib/main_dev.dart`**

```dart
import 'package:yogasala_plus_mobile/app/app_config.dart';
import 'package:yogasala_plus_mobile/bootstrap/bootstrap.dart';

Future<void> main() async {
  await Bootstrap.initialize(
    flavor: Flavor.dev,
    envPath: '.env.dev',
  );
}
```

Same for staging/prod with matching flavor and env path.

**`lib/main.dart`**

```dart
export 'main_dev.dart';
```

### 9.3 `lib/bootstrap/bootstrap.dart`

Order:

1. `WidgetsFlutterBinding.ensureInitialized()`
2. `dotenv.load(fileName: envPath)`
3. `AppConfig.fromEnv(flavor)`
4. Firebase:

```dart
if (Firebase.apps.isEmpty) {
  await Firebase.initializeApp(options: appConfig.firebaseOptions);
}
```

5. `EasyLocalization.ensureInitialized()`
6. `getIt.registerSingleton<AppConfig>(appConfig)` **before** injectable init
7. `configureDependencies()`
8. `initializeAppServices()`
9. `runApp` with `MultiBlocProvider` (Theme + Auth)

Move UI widget to `lib/app/app.dart` as `YogaSalaPlusApp` (title from `appConfig.appName`).

### 9.4 Network module uses AppConfig

Replace hardcoded jsonplaceholder-only config:

```dart
@lazySingleton
NetworkClientConfig networkClientConfig(AppConfig config) => NetworkClientConfig(
  baseUrl: config.apiBaseUrl.isNotEmpty
      ? config.apiBaseUrl
      : 'https://jsonplaceholder.typicode.com',
);
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 10. Step 3 — Firebase Authentication

### 10.1 Approach

Keep domain/UI. Swap only remote:

```text
LoginPage → AuthBloc → LoginUseCase → AuthRepositoryImpl
                              ↓
                    AuthRemoteDataSource  ← Firebase impl
                              ↓
                    AuthLocalDataSource   (cache id token)
```

REST `AuthApiClient` can remain unused.

### 10.2 FirebaseModule

`lib/di/modules/firebase_module.dart`:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
```

### 10.3 Firebase remote (what we implemented)

We implemented Firebase inside `AuthRemoteDataSourceImpl` (same interface), including:

- `signInWithEmailAndPassword`
- `signOut`
- `getIdToken(true)` / `getIdTokenResult` for refresh
- Map `User` → `UserModel` + `AuthTokensModel` (ID token as access/refresh placeholders; Firebase manages refresh internally)

Remove any second `@LazySingleton(as: AuthRemoteDataSource)` so injectable has one binding.

### 10.4 isAuthenticated

```dart
@override
Future<bool> isAuthenticated() async {
  return FirebaseAuth.instance.currentUser != null;
}
```

(Preferred over only checking local token expiry, so session restores after app kill.)

### 10.5 Manual test

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

Log in with Console test user → protected home → kill/reopen stays logged in → logout → login again.

### 10.6 AuthInterceptor

Still **optional**. `network_module` may not attach `AuthInterceptor` yet — fine while posts use public jsonplaceholder. Add later for `Authorization: Bearer <Firebase ID token>`.

---

## 11. Navigation & AuthGuard (best practice)

### 11.1 You already had a login page

| File | Role |
|------|------|
| `login_page.dart` | Screen |
| `login_form.dart` | Email / password / Sign in |
| `/login` | In `app_router.dart` |

Home `/` (`PostsDemoRoute`) is guarded → unauthenticated users get Login pushed.

### 11.2 Double navigation bug

We had **both**:

- Guard: `onResult` → `replace(resolver.route as PageRouteInfo…)`
- LoginPage: `onResult` **and** `replace(PostsDemoRoute())`

And the broken guard pattern:

```dart
await router.push(LoginRoute(...));
resolver.resolveNext(false); // always cancels original /
```

`resolver.route as PageRouteInfo` is fragile → replace often no-ops → stuck on login after success.

### 11.3 Scalable best practice (many pages)

**Guard owns continuing the original route; LoginPage only signals success.**

```dart
// AuthGuard — protected routes
if (requiresAuth) {
  unawaited(
    router.push(
      LoginRoute(
        onResult: ({bool? success}) {
          resolver.resolveNext(success == true);
        },
      ),
    ),
  );
  return; // do NOT await push then resolveNext(false)
}
```

```dart
// LoginPage — authenticated
authenticated: (_) {
  onResult?.call(success: true);
  if (onResult == null) {
    unawaited(context.router.replace(const PostsDemoRoute()));
  }
},
```

Flow:

```text
Open / (or deep link)
  → AuthGuard (not logged in)
  → push LoginRoute
  → sign in OK
  → onResult(success: true)
  → resolver.resolveNext(true)
  → original route proceeds
```

As the app grows: put `AuthGuard()` on every private route (or a shell parent); `AuthGuard(requiresAuth: false)` only on `/login`, `/register`, etc.

---

## 12. Logout

### 12.1 Race in posts_demo_page

Bad:

```dart
context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
context.router.replace(LoginRoute()); // immediate — still may be authenticated
```

Login has `requiresAuth: false`. If still authed, guard does `replace(PostsDemoRoute)` → bounce back to posts.

### 12.2 Correct pattern

```dart
// Button — only dispatch
onPressed: () {
  context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
},

// BlocListener — navigate when done
BlocListener<AuthBloc, AuthState>(
  listenWhen: (prev, curr) =>
      prev != curr &&
      curr.maybeWhen(unauthenticated: () => true, orElse: () => false),
  listener: (context, state) {
    context.router.replace(LoginRoute());
  },
  child: Scaffold(...),
);
```

**Rule:** bloc owns session; navigation reacts to state (same idea as login).

---

## 13. How to run

Always pass **flavor** and **target**:

```bash
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor staging -t lib/main_staging.dart
flutter run --flavor prod -t lib/main_prod.dart
```

Never a bare `flutter run` without flavor once flavors are set up.

---

## 14. Master checklist

### Firebase / flavors

- [x] 3 Firebase projects
- [x] Android apps with short package names
- [x] iOS apps with matching bundle IDs
- [x] Email/Password on all three
- [x] CLI: firebase + flutterfire
- [x] `firebase_options_{dev,staging,prod}.dart`
- [x] `.env.{dev,staging,prod}` + assets
- [x] Android product flavors + 3× `google-services.json`
- [x] Google Services Gradle plugin
- [x] iOS Podfile + `platform :ios, '15.0'`
- [x] Root Dev/Staging/Prod xcconfigs
- [x] 9 mode+flavor xcconfigs (Pods + flavor)
- [x] No duplicate Flutter/Dev|Staging|Prod
- [x] Xcode configs point at Debug-dev etc. (not bare Pods / bare Dev)
- [x] Schemes `dev` / `staging` / `prod`
- [x] `ios/config/*/GoogleService-Info.plist` + copy script
- [x] One Runner plist in Copy Bundle Resources
- [x] `AppConfig` + Bootstrap + `main_*.dart`
- [x] Firebase `apps.isEmpty` guard (confirm in bootstrap)

### Auth / navigation

- [x] Firebase remote login/logout/refresh
- [x] `FirebaseModule` + DI regenerate
- [x] `isAuthenticated` via `currentUser`
- [x] Login page + form already in app
- [x] Guard: `resolver.resolveNext(success == true)`
- [x] Logout waits for `unauthenticated` before navigate

### Pending

- [ ] Fastlane
- [ ] GitHub Actions CI/CD
- [ ] AuthInterceptor with ID token for real API
- [ ] Per-flavor icons / `CFBundleDisplayName = $(APP_NAME)`

---

## 15. What’s next (Fastlane / CI/CD)

| Step | Topic |
|------|--------|
| **4** | `android/fastlane` + `ios/fastlane` lanes per flavor |
| **5** | CI: analyze, test, build on PR |
| **6** | CD: TestFlight / Play internal + secrets |

Boilerplate reference: `.github/workflows/ci.yml`, `cd.yml`, `scripts/deploy/deploy_playstore.sh` (Supply). YogaSala can mirror that and add Fastlane lanes.

---

## 16. Troubleshooting encyclopedia

| Problem | Cause / Fix |
|---------|-------------|
| FlutterFire left only one `google-services.json` | Overwrite on each configure — place 3 copies under `src/{dev,staging,prod}/` |
| `No Podfile found` | Missing file on Flutter 3.44 — copy from `templates/cocoapods/Podfile-ios` |
| Assigning iOS 15.6 because no platform | Uncomment `platform :ios, '15.0'` in Podfile |
| CocoaPods base configuration warnings | Include Pods in mode+flavor xcconfigs; point Xcode at those files |
| Bundle identifier missing | Base was Pods-only or circular `$(PRODUCT_BUNDLE_IDENTIFIER)` without Dev.xcconfig in chain |
| `duplicate-app` `[DEFAULT]` | Native plist init + Dart init — use `Firebase.apps.isEmpty` |
| Copy script echo not in flutter log | Look in Xcode Report navigator; verify with PlistBuddy on Runner plist |
| Script not in project | Confirm Build Phases on **TARGETS → Runner**; re-add script |
| Removed plist from Copy Bundle Resources | Add `Runner/GoogleService-Info.plist` back (one entry) |
| Wrong Firebase project while on dev | Copy script not running / stale prod plist in Runner |
| Xcode duplicates Profile.xcconfig | Don’t File→New; write on disk; or ignore Profile warning |
| After login stuck on login page | Use `resolveNext(true)` on success; don’t await push + `resolveNext(false)` |
| Logout returns to posts | Don’t open Login until `unauthenticated` |
| Posts fail after wiring AppConfig | `.env` points at missing API — use jsonplaceholder for now |
| `main_dev.dart` not found | Create entrypoints before `flutter run -t …` |
| Login page “missing” | Already exists; may be session still authenticated or stuck on `isChecking` |

---

## Locked ID quick reference

| Flavor | Android / iOS ID |
|--------|------------------|
| prod | `com.yogasala.plus.mobile` |
| staging | `com.yogasala.plus.mobile.staging` |
| dev | `com.yogasala.plus.mobile.dev` |

---

*Expanded from the Yoga Sala Plus Mobile working sessions (flavors, Firebase, auth, navigation). Patterns referenced from `flutter_enterprise_boilerplate`.*
