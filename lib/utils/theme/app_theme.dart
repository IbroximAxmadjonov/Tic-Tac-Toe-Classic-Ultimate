import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_text_theme.dart';

part 'app_color_scheme.dart';

class AppTheme {
  static ThemeData get light => _buildTheme(AppColorScheme.light);
  static ThemeData get dark => _buildTheme(AppColorScheme.dark);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final textTheme = AppTextTheme.buildTextTheme(colorScheme.onSurface);
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Gilroy',

      /// ====================== UI ======================
      scaffoldBackgroundColor: colorScheme.surface,

      /// ================= AppBar =================
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.onSurface,
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        titleTextStyle: textTheme.bodyLarge,
        elevation: 0,
      ),

      /// ================= ElevatedButton =================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.outline,
          disabledBackgroundColor: colorScheme.onSurfaceVariant,
          overlayColor: colorScheme.primary.withAlpha(1),
          textStyle: textTheme.bodyMedium,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          fixedSize: Size(350.w, 60.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.r)),
          alignment: Alignment.center,
        ),
      ),

      /// ================= IconButton =================
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.outline,
          disabledBackgroundColor: colorScheme.onSurfaceVariant,
          overlayColor: colorScheme.primary.withAlpha(1),
          iconSize: 24.sp,
          padding: EdgeInsets.symmetric(vertical: 24.5.h),
          fixedSize: Size(45.67.r, 45.67.r),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.r)),
          alignment: Alignment.center,
        ),
      ),

      /// ================= TextButton =================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          backgroundColor: colorScheme.surface,
          textStyle: textTheme.labelMedium,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),

      /// ================= Card =================
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        margin: EdgeInsetsGeometry.all(2.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(18.r),
          side: BorderSide(color: colorScheme.outline, width: 1),
        ),
        elevation: 0,
      ),

      /// ================= Divider =================
      dividerTheme: DividerThemeData(
        space: 16.h,
        thickness: 1,
        color: colorScheme.outline,
      ),

      /// ================= BottomNavigationBar =================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall,
      ),

      /// ================= Input =================
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textTheme.bodyMedium,
        labelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        suffixIconColor: colorScheme.outline,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
      ),
    );
  }
}
