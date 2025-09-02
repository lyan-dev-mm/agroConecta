# Conservar clases y métodos de Firebase que podrían usarse por reflexión
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Mantener anotaciones importantes
-keepattributes *Annotation*

# Mantener clases con @Keep
-keep class * {
    @androidx.annotation.Keep *;
}
