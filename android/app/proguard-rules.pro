# Preserve AndroidX WindowManager for multi-window and foldable device support
-keep class androidx.window.** { *; }
-dontwarn androidx.window.**