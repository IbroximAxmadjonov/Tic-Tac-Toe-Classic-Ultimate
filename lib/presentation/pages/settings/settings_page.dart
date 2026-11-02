import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/manager/setting_bloc/setting_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../generated/slang/slang.g.dart';
import '../../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.t.settings.title)),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ================= Настройки игры =================
                  ModeSelectorWidget(
                    selectedMode: state.gameMode,
                    onModeChanged: (value) {
                      context.read<SettingBloc>().add(
                        ChangeGameModeSettingEvent(gameMode: value),
                      );
                    },
                  ),
                  GridSizeSelectorWidget(
                    isVisible:
                    state.gameMode == GameMode.threeInARow ||
                        state.gameMode == GameMode.expanded,
                    selectedSize: state.selectedSize,
                    onSizeChanged: (value) {
                      context.read<SettingBloc>().add(
                        ChangeSelectedSizeSettingEvent(selectedSize: value),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // ================= Язык =================
                  SectionCard(
                    icon: Icons.language_rounded,
                    title: context.t.settings.language,
                    child: Row(
                      children: [
                        Expanded(
                          child: TileWidget(
                            value: AppLocale.ru,
                            title: 'Русский',
                            isSelected: state.appLocale == AppLocale.ru,
                            onSelected: (locale) {
                              context.read<SettingBloc>().add(
                                ChangeLanguageSettingEvent(
                                  locale: locale as AppLocale,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TileWidget(
                            value: AppLocale.en,
                            title: 'English',
                            isSelected: state.appLocale == AppLocale.en,
                            onSelected: (locale) {
                              context.read<SettingBloc>().add(
                                ChangeLanguageSettingEvent(
                                  locale: locale as AppLocale,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TileWidget(
                            value: AppLocale.uz,
                            title: "O'zbek",
                            isSelected: state.appLocale == AppLocale.uz,
                            onSelected: (locale) {
                              context.read<SettingBloc>().add(
                                ChangeLanguageSettingEvent(
                                  locale: locale as AppLocale,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ================= Тема оформления =================
                  SectionCard(
                    icon: Icons.palette_outlined,
                    title: context.t.settings.theme.title,
                    child: Row(
                      children: [
                        Expanded(
                          child: TileWidget(
                            value: ThemeMode.system,
                            title: context.t.settings.theme.system,
                            icon: Icons.brightness_auto_rounded,
                            isSelected: state.themeMode == ThemeMode.system,
                            onSelected: (_) {
                              context.read<SettingBloc>().add(
                                ChangeThemeModeSettingEvent(
                                  themeMode: ThemeMode.system,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TileWidget(
                            value: ThemeMode.light,
                            title: context.t.settings.theme.light,
                            icon: Icons.light_mode_rounded,
                            isSelected: state.themeMode == ThemeMode.light,
                            onSelected: (_) {
                              context.read<SettingBloc>().add(
                                ChangeThemeModeSettingEvent(
                                  themeMode: ThemeMode.light,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TileWidget(
                            value: ThemeMode.dark,
                            title: context.t.settings.theme.dark,
                            icon: Icons.dark_mode_rounded,
                            isSelected: state.themeMode == ThemeMode.dark,
                            onSelected: (_) {
                              context.read<SettingBloc>().add(
                                ChangeThemeModeSettingEvent(
                                  themeMode: ThemeMode.dark,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ================= Звук и вибрация =================
                  SectionCard(
                    icon: Icons.volume_up_rounded,
                    title: context.t.settings.audio.title,
                    child: Column(
                      children: [
                        ListTileSwitchWidget(
                          icon: Icon(
                            Icons.music_note_rounded,
                            size: 22,
                            color: colorScheme.primary,
                          ),
                          title: context.t.settings.audio.sound.title,
                          subtitle: context.t.settings.audio.sound.subtitle,
                          value: state.isMusicEnabled,
                          onChanged: (value) {
                            context.read<SettingBloc>().add(
                              ToggleMusicSettingEvent(),
                            );
                          },
                        ),
                        Divider(),
                        ListTileSwitchWidget(
                          icon: Icon(
                            Icons.vibration_rounded,
                            size: 22,
                            color: colorScheme.primary,
                          ),
                          title: context.t.settings.audio.vibration.title,
                          subtitle: context.t.settings.audio.vibration.subtitle,
                          value: state.isSoundEnabled,
                          onChanged: (value) {
                            context.read<SettingBloc>().add(
                              ToggleSoundSettingEvent(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ================= Об игре =================
                  SectionCard(
                    icon: Icons.info_outline_rounded,
                    title: context.t.settings.about.title,
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withAlpha(25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colorScheme.primary.withAlpha(60),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.grid_3x3_rounded,
                            color: colorScheme.primary,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tic Tac Toe: Classic & Ultimate',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                context.t.settings.about.version,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
