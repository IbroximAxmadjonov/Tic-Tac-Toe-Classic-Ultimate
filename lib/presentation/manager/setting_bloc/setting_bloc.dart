import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../generated/slang/slang.g.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends HydratedBloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    // ── 1. Настройки режима игры ──────────────────────────────────────────────
    on<ChangeGameModeSettingEvent>((event, emit) {
      emit(state.copyWith(gameMode: event.gameMode));
    });

    on<ChangeSelectedSizeSettingEvent>((event, emit) {
      emit(state.copyWith(selectedSize: event.selectedSize));
    });

    on<ChangeSaveGameSettingEvent>((event, emit) {
      emit(state.copyWith(saveGame: event.saveGame));
    });

    // ── 2. Настройки темы ─────────────────────────────────────────────────────
    on<ChangeThemeModeSettingEvent>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    // ── 3. Настройки языка [английский, русский, узбекский] ──────────────────
    on<ChangeLanguageSettingEvent>((event, emit) async {
      await LocaleSettings.setLocale(event.locale);
      emit(state.copyWith(appLocale: event.locale));
    });

    // ── 4. Пустышки (для дальнейшей реализации) ───────────────────────────────
    on<ChangeCustomXIconSettingEvent>((event, emit) {
      emit(state.copyWith(customXIcon: event.icon));
    });

    on<ChangeCustomOIconSettingEvent>((event, emit) {
      emit(state.copyWith(customOIcon: event.icon));
    });

    on<ChangeSoundVolumeSettingEvent>((event, emit) {
      emit(state.copyWith(soundVolume: event.volume));
    });

    on<ChangeMusicVolumeSettingEvent>((event, emit) {
      emit(state.copyWith(musicVolume: event.volume));
    });

    on<ToggleSoundSettingEvent>((event, emit) {
      emit(state.copyWith(isSoundEnabled: !state.isSoundEnabled));
    });

    on<ToggleMusicSettingEvent>((event, emit) {
      emit(state.copyWith(isMusicEnabled: !state.isMusicEnabled));
    });

    on<ShareAppSettingEvent>((event, emit) {
      // Пустышка: Share App
    });

    on<BuyMeACoffeeSettingEvent>((event, emit) {
      // Пустышка: Buy me a coffee
    });

    on<OpenPrivacyPolicySettingEvent>((event, emit) {
      // Пустышка: Privacy Policy
    });

    on<OpenTermsOfServiceSettingEvent>((event, emit) {
      // Пустышка: Terms of Service
    });
  }

  @override
  SettingState? fromJson(Map<String, dynamic> json) {
    try {
      final restoredState = SettingState.fromJson(json);
      LocaleSettings.setLocale(restoredState.appLocale);
      return restoredState;
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    return state.toJson();
  }
}
