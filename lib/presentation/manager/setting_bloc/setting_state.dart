part of 'setting_bloc.dart';

class SettingState extends Equatable {
  // 1. Настройки режима игры
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;

  // 2. Настройки темы
  final ThemeMode themeMode;

  // 3. Настройки языка [английский, русский, узбекский]
  final AppLocale appLocale;

  // 4. Пустышки (для дальнейшей реализации):
  // Смена иконок X, O на другое
  final String customXIcon;
  final String customOIcon;

  // Громкость звука и музыки
  final double soundVolume;
  final double musicVolume;
  final bool isSoundEnabled;
  final bool isMusicEnabled;

  const SettingState({
    this.gameMode = GameMode.classic,
    this.selectedSize = 4,
    this.saveGame = SaveGame.no,
    this.themeMode = ThemeMode.system,
    this.appLocale = AppLocale.ru,
    this.customXIcon = 'X',
    this.customOIcon = 'O',
    this.soundVolume = 1.0,
    this.musicVolume = 1.0,
    this.isSoundEnabled = true,
    this.isMusicEnabled = true,
  });

  SettingState copyWith({
    GameMode? gameMode,
    int? selectedSize,
    SaveGame? saveGame,
    ThemeMode? themeMode,
    AppLocale? appLocale,
    String? customXIcon,
    String? customOIcon,
    double? soundVolume,
    double? musicVolume,
    bool? isSoundEnabled,
    bool? isMusicEnabled,
  }) {
    return SettingState(
      gameMode: gameMode ?? this.gameMode,
      selectedSize: selectedSize ?? this.selectedSize,
      saveGame: saveGame ?? this.saveGame,
      themeMode: themeMode ?? this.themeMode,
      appLocale: appLocale ?? this.appLocale,
      customXIcon: customXIcon ?? this.customXIcon,
      customOIcon: customOIcon ?? this.customOIcon,
      soundVolume: soundVolume ?? this.soundVolume,
      musicVolume: musicVolume ?? this.musicVolume,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isMusicEnabled: isMusicEnabled ?? this.isMusicEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameMode': gameMode.index,
      'selectedSize': selectedSize,
      'saveGame': saveGame.index,
      'themeMode': themeMode.index,
      'appLocale': appLocale.languageCode,
      'customXIcon': customXIcon,
      'customOIcon': customOIcon,
      'soundVolume': soundVolume,
      'musicVolume': musicVolume,
      'isSoundEnabled': isSoundEnabled,
      'isMusicEnabled': isMusicEnabled,
    };
  }

  factory SettingState.fromJson(Map<String, dynamic> json) {
    AppLocale locale = AppLocale.ru;
    final localeStr = json['appLocale'] as String?;
    if (localeStr == 'en') {
      locale = AppLocale.en;
    } else if (localeStr == 'uz') {
      locale = AppLocale.uz;
    }

    return SettingState(
      gameMode: GameMode.values[json['gameMode'] as int? ?? 0],
      selectedSize: json['selectedSize'] as int? ?? 4,
      saveGame: SaveGame.values[json['saveGame'] as int? ?? 1],
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
      appLocale: locale,
      customXIcon: json['customXIcon'] as String? ?? 'X',
      customOIcon: json['customOIcon'] as String? ?? 'O',
      soundVolume: (json['soundVolume'] as num?)?.toDouble() ?? 1.0,
      musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 1.0,
      isSoundEnabled: json['isSoundEnabled'] as bool? ?? true,
      isMusicEnabled: json['isMusicEnabled'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [
    gameMode,
    selectedSize,
    saveGame,
    themeMode,
    appLocale,
    customXIcon,
    customOIcon,
    soundVolume,
    musicVolume,
    isSoundEnabled,
    isMusicEnabled,
  ];
}
