part of 'app_theme.dart';

abstract final class AppColorScheme {
  // ===========================================================================
  // LIGHT MODE COLORS
  // ===========================================================================

  /// Основной цвет бренда (кнопки, активные элементы, акценты)
  static const Color lightPrimary = Color(0xFF1244A1);

  /// Цвет элементов и текста на primary
  static const Color lightOnPrimary = Colors.white;

  /// Вторичный цвет (акцентные значки, второй игрок, бейджи)
  static const Color lightSecondary = Color(0xFFE4383F);

  /// Цвет элементов и текста на secondary
  static const Color lightOnSecondary = Colors.white;

  /// Цвет поверхности и фона экранов
  static const Color lightSurface = Color(0xFFF4EFEA);

  /// Основной текст и иконки на поверхности
  static const Color lightOnSurface = Color(0xFF191C20);

  /// Второстепенный текст, подсказки и неактивные элементы
  static const Color lightOnSurfaceVariant = Color(0xFF74777F);

  /// Контейнеры, карточки, ячейки и подложки
  static const Color lightSurfaceContainer = Color(0xFFEAE5E0);

  /// Повышенные контейнеры / приподнятые карточки
  static const Color lightSurfaceContainerHighest = Color(0xFFDFDAD5);

  /// Линии, сетка и разделители
  static const Color lightOutline = Color(0xFFD2CCC5);

  /// Второстепенные границы и тонкие разделители
  static const Color lightOutlineVariant = Color(0xFFE2DDD7);

  /// Цвет ошибки
  static const Color lightError = Color(0xFFBA1A1A);

  /// Цвет текста на ошибке
  static const Color lightOnError = Colors.white;

  // ===========================================================================
  // DARK MODE COLORS
  // Измените цвета ниже на нужные вам для тёмной темы:
  // ===========================================================================

  /// Основной цвет для Dark Mode (кнопки, активные элементы, акценты)
  static const Color darkPrimary = Color(0xFF4C7EE8);

  /// Цвет элементов и текста на primary
  static const Color darkOnPrimary = Colors.white;

  /// Вторичный цвет для Dark Mode (акцентные значки, второй игрок, бейджи)
  static const Color darkSecondary = Color(0xFFFF525A);

  /// Цвет элементов и текста на secondary
  static const Color darkOnSecondary = Colors.white;

  /// Цвет поверхности и фона экранов для Dark Mode
  static const Color darkSurface = Color(0xFF141519);

  /// Основной текст и иконки на поверхности
  static const Color darkOnSurface = Color(0xFFF4EFEA);

  /// Второстепенный текст, подсказки и неактивные элементы
  static const Color darkOnSurfaceVariant = Color(0xFFA0A4AE);

  /// Контейнеры, карточки, ячейки и подложки для Dark Mode
  static const Color darkSurfaceContainer = Color(0xFF1F2128);

  /// Повышенные контейнеры / приподнятые карточки для Dark Mode
  static const Color darkSurfaceContainerHighest = Color(0xFF272931);

  /// Линии, сетка и разделители для Dark Mode
  static const Color darkOutline = Color(0xFF363945);

  /// Второстепенные границы и тонкие разделители для Dark Mode
  static const Color darkOutlineVariant = Color(0xFF2A2D36);

  /// Цвет ошибки для Dark Mode
  static const Color darkError = Color(0xFFFFB4AB);

  /// Цвет текста на ошибке
  static const Color darkOnError = Color(0xFF690005);

  // ===========================================================================
  // COLOR SCHEMES
  // ===========================================================================

  /// Светлая цветовая схема Material 3
  static const ColorScheme light = ColorScheme.light(
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    surface: lightSurface,
    onSurface: lightOnSurface,
    onSurfaceVariant: lightOnSurfaceVariant,
    surfaceContainer: lightSurfaceContainer,
    surfaceContainerHighest: lightSurfaceContainerHighest,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,
    error: lightError,
    onError: lightOnError,
  );

  /// Тёмная цветовая схема Material 3
  static const ColorScheme dark = ColorScheme.dark(
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    surface: darkSurface,
    onSurface: darkOnSurface,
    onSurfaceVariant: darkOnSurfaceVariant,
    surfaceContainer: darkSurfaceContainer,
    surfaceContainerHighest: darkSurfaceContainerHighest,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,
    error: darkError,
    onError: darkOnError,
  );
}
