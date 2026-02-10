plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter plugin MUST come after Android & Kotlin
    id("dev.flutter.flutter-gradle-plugin")

    // Google Services plugin MUST be applied here
    id("com.google.gms.google-services")
}

android {
    namespace = "com.birang.try_firebase"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.birang.try_firebase"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.9.0"))

    // Firebase products
    implementation("com.google.firebase:firebase-analytics")
}

flutter {
    source = "../.."
}
