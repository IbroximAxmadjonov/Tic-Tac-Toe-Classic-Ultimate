part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

// ── 1. Настройки режима игры ────────────────────────────────────────────────
class ChangeGameModeSettingEvent extends SettingEvent {
  final GameMode gameMode;

  const ChangeGameModeSettingEvent({required this.gameMode});

  @override
  List<Object?> get props => [gameMode];
}

class ChangeSelectedSizeSettingEvent extends SettingEvent {
  final int selectedSize;

  const ChangeSelectedSizeSettingEvent({required this.selectedSize});

  @override
  List<Object?> get props => [selectedSize];
}

class ChangeSaveGameSettingEvent extends SettingEvent {
  final SaveGame saveGame;

  const ChangeSaveGameSettingEvent({required this.saveGame});

  @override
  List<Object?> get props => [saveGame];
}

// ── 2. Настройки темы ───────────────────────────────────────────────────────
class ChangeThemeModeSettingEvent extends SettingEvent {
  final ThemeMode themeMode;

  const ChangeThemeModeSettingEvent({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}

// ── 3. Настройки языка [английский, русский, узбекский] ────────────────────
class ChangeLanguageSettingEvent extends SettingEvent {
  final AppLocale locale;

  const ChangeLanguageSettingEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}

// ── 4. Пустышки (для дальнейшей реализации) ────────────────────────────────

/// Смена иконки X на другое
class ChangeCustomXIconSettingEvent extends SettingEvent {
  final String icon;

  const ChangeCustomXIconSettingEvent({required this.icon});

  @override
  List<Object?> get props => [icon];
}

/// Смена иконки O на другое
class ChangeCustomOIconSettingEvent extends SettingEvent {
  final String icon;

  const ChangeCustomOIconSettingEvent({required this.icon});

  @override
  List<Object?> get props => [icon];
}

/// Громкость звука
class ChangeSoundVolumeSettingEvent extends SettingEvent {
  final double volume;

  const ChangeSoundVolumeSettingEvent({required this.volume});

  @override
  List<Object?> get props => [volume];
}

/// Громкость музыки
class ChangeMusicVolumeSettingEvent extends SettingEvent {
  final double volume;

  const ChangeMusicVolumeSettingEvent({required this.volume});

  @override
  List<Object?> get props => [volume];
}

/// Включение/выключение звука
class ToggleSoundSettingEvent extends SettingEvent {
  const ToggleSoundSettingEvent();
}

/// Включение/выключение музыки
class ToggleMusicSettingEvent extends SettingEvent {
  const ToggleMusicSettingEvent();
}

/// Пустышка: Share App
class ShareAppSettingEvent extends SettingEvent {
  const ShareAppSettingEvent();
}

/// Пустышка: Buy me a coffee
class BuyMeACoffeeSettingEvent extends SettingEvent {
  const BuyMeACoffeeSettingEvent();
}

/// Пустышка: Privacy Policy
class OpenPrivacyPolicySettingEvent extends SettingEvent {
  const OpenPrivacyPolicySettingEvent();
}

/// Пустышка: Terms of Service
class OpenTermsOfServiceSettingEvent extends SettingEvent {
  const OpenTermsOfServiceSettingEvent();
}
