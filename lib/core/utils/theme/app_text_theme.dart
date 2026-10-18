part of 'app_theme.dart';

abstract final class AppTextTheme {
  static TextTheme buildTextTheme(Color color) {
    return TextTheme(

      /// Display
      displayLarge: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w600),
      // displayMedium: TextStyle(fontSize:, fontWeight:),
      // displaySmall: TextStyle(fontSize:, fontWeight:),
      /// Headline
      headlineLarge: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w300),
      headlineMedium: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800),
      headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),

      /// Title
      titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w300),
      // titleMedium: TextStyle(fontSize:, fontWeight:),
      // titleSmall: TextStyle(fontSize:, fontWeight:),
      /// Body
      bodyLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
      bodyMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
      bodySmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),

      /// Label
      labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
      labelMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
      labelSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
    ).apply(
      bodyColor: color,
      displayColor: color,
      decorationColor: color,
      fontFamily: 'Gilroy',
    );
  }
}
