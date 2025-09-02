plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

    //id("org.jetbrains.kotlin.android")

    // Este es el plugin de Google Services para Firebase
    id("com.google.gms.google-services")

}

dependencies {
    // Esto importa la BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))

    // Agrega aquí los SDKs de Firebase que usarás
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation ("androidx.core:core:1.8.0")

}


android {
    namespace = "com.agroconecta.app"
    compileSdk = 35 //34 -- flutter.compileSdkVersion
    //ndkVersion = flutter.ndkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17 //2do: version_17 1er:JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_17 //JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget =  JavaVersion.VERSION_17.toString() //JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.agroconecta.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 35 //34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // Antes : signingConfig = signingConfigs.getByName("debug")

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

