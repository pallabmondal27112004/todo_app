# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Keep OkHttp / Retrofit / Dio / HTTP clients
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-keep class retrofit2.** { *; }
-keep class com.google.gson.** { *; }
-keep class com.fasterxml.jackson.** { *; }

# Keep JSON models (if using reflection)
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
