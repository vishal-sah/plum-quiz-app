# Keep Flutter Gemini classes
-keep class io.flutter.plugins.** { *; }
-keep class dev.flutter.pigeon.** { *; }

# Keep Gemini related classes
-keep class com.google.ai.** { *; }
-keep class com.google.generativeai.** { *; }

# Keep JSON parsing classes
-keep class com.google.gson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

# Keep network related classes
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }

# Keep model classes for JSON serialization
-keep class ** {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Don't obfuscate
-dontobfuscate