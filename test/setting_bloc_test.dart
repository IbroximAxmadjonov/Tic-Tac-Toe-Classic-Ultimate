// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:tic_tac_toe/domain/constants/enums.dart';
// import 'package:tic_tac_toe/generated/slang/slang.g.dart';
// import 'package:tic_tac_toe/presentation/manager/setting_bloc/setting_bloc.dart';
//
// class _FakeHydratedStorage implements HydratedStorage {
//   final Map<String, dynamic> _data = {};
//
//   @override
//   dynamic read(String key) => _data[key];
//
//   @override
//   Future<void> write(String key, dynamic value) async {
//     _data[key] = value;
//   }
//
//   @override
//   Future<void> delete(String key) async {
//     _data.remove(key);
//   }
//
//   @override
//   Future<void> clear() async {
//     _data.clear();
//   }
//
//   @override
//   Future<void> close() async {}
// }
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late HydratedStorage storage;
//
//   setUp(() {
//     storage = _FakeHydratedStorage();
//     HydratedBloc.storage = storage;
//   });
//
//   group('SettingBloc Tests', () {
//     test('initial state has default values', () {
//       final bloc = SettingBloc(homeBloc: Home);
//       expect(bloc.state.gameMode, GameMode.classic);
//       expect(bloc.state.selectedSize, 4);
//       expect(bloc.state.saveGame, SaveGame.no);
//       expect(bloc.state.themeMode, ThemeMode.system);
//       expect(bloc.state.appLocale, AppLocale.ru);
//       expect(bloc.state.customXIcon, 'X');
//       expect(bloc.state.customOIcon, 'O');
//       expect(bloc.state.soundVolume, 1.0);
//       expect(bloc.state.musicVolume, 1.0);
//       expect(bloc.state.isSoundEnabled, true);
//       expect(bloc.state.isMusicEnabled, true);
//       bloc.close();
//     });
//
//     test('updates gameMode on ChangeGameModeSettingEvent', () async {
//       final bloc = SettingBloc();
//       bloc.add(const ChangeGameModeSettingEvent(gameMode: GameMode.ultimate));
//       await expectLater(
//         bloc.stream,
//         emits(predicate<SettingState>((s) => s.gameMode == GameMode.ultimate)),
//       );
//       bloc.close();
//     });
//
//     test('updates themeMode on ChangeThemeModeSettingEvent', () async {
//       final bloc = SettingBloc();
//       bloc.add(const ChangeThemeModeSettingEvent(themeMode: ThemeMode.dark));
//       await expectLater(
//         bloc.stream,
//         emits(predicate<SettingState>((s) => s.themeMode == ThemeMode.dark)),
//       );
//       bloc.close();
//     });
//
//     test('updates language and syncs slang on ChangeLanguageSettingEvent', () async {
//       final bloc = SettingBloc();
//       bloc.add(const ChangeLanguageSettingEvent(locale: AppLocale.en));
//       await expectLater(
//         bloc.stream,
//         emits(predicate<SettingState>((s) => s.appLocale == AppLocale.en)),
//       );
//       expect(LocaleSettings.currentLocale, AppLocale.en);
//
//       bloc.add(const ChangeLanguageSettingEvent(locale: AppLocale.uz));
//       await expectLater(
//         bloc.stream,
//         emits(predicate<SettingState>((s) => s.appLocale == AppLocale.uz)),
//       );
//       expect(LocaleSettings.currentLocale, AppLocale.uz);
//
//       bloc.close();
//     });
//
//     test('updates audio volume and toggles', () async {
//       final bloc = SettingBloc();
//       bloc.add(const ChangeSoundVolumeSettingEvent(volume: 0.5));
//       bloc.add(const ChangeMusicVolumeSettingEvent(volume: 0.7));
//       bloc.add(const ToggleSoundSettingEvent());
//       bloc.add(const ToggleMusicSettingEvent());
//
//       await expectLater(
//         bloc.stream,
//         emitsInOrder([
//           predicate<SettingState>((s) => s.soundVolume == 0.5),
//           predicate<SettingState>((s) => s.musicVolume == 0.7),
//           predicate<SettingState>((s) => !s.isSoundEnabled),
//           predicate<SettingState>((s) => !s.isMusicEnabled),
//         ]),
//       );
//       bloc.close();
//     });
//
//     test('serialization toJson and fromJson restores state', () {
//       final bloc = SettingBloc();
//       const state = SettingState(
//         gameMode: GameMode.expanded,
//         selectedSize: 5,
//         saveGame: SaveGame.yes,
//         themeMode: ThemeMode.light,
//         appLocale: AppLocale.uz,
//         customXIcon: '❌',
//         customOIcon: '⭕',
//         soundVolume: 0.8,
//         musicVolume: 0.4,
//         isSoundEnabled: false,
//         isMusicEnabled: false,
//       );
//
//       final json = bloc.toJson(state);
//       expect(json, isNotNull);
//
//       final restored = bloc.fromJson(json!);
//       expect(restored, equals(state));
//       expect(LocaleSettings.currentLocale, AppLocale.uz);
//
//       bloc.close();
//     });
//   });
// }
