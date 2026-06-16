plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.rtchoke.flutter_enterprise_boilerplate"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.rtchoke.flutter_enterprise_boilerplate"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // flavorDimensions Allows you to combine multiple product flavors. 
    // Here we use “default” since we have only one flavor dimension.
    // Example
    // dimensions: env (dev, prod, staging) + brand (free, pro)
    // build type: debug, release
    // variants generated: devFreeDebug, devProRelease, prodFreeDebug, etc...
    // manifestPlaceholders["appName"] = "Flutter Enterprise Boilerplate [STG]"
    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Flutter Enterprise Boilerplate [DEV]")
            manifestPlaceholders = [
                appIcon: "@mipmap/lamberb_ic_launcher_288_dev",
            ]
        }
        create("staging") {
            dimension = "env"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Flutter Enterprise Boilerplate [STG]")
            manifestPlaceholders = [
                appIcon: "@mipmap/lamberb_ic_launcher_288_staging",
            ]
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "Flutter Enterprise Boilerplate")
            manifestPlaceholders = [
                appIcon: "@mipmap/lamberb_ic_launcher_288",
            ]
        }
    }
}

flutter {
    source = "../.."
}
