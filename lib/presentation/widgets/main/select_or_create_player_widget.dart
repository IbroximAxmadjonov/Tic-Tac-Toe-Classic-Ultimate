import 'package:flutter/material.dart';

import '../../../domain/entities/player_entity.dart';
import '../../widgets/main/grid_section_card.dart';

// ============================================================================
// BLOC INTEGRATION NOTES (TODO: connect with Bloc)
// ============================================================================
// 1. Получение списка игроков из Bloc:
//    BlocBuilder<PlayerBloc, PlayerState>(
//      builder: (context, state) {
//        final players = state is PlayersLoaded ? state.players : <PlayerEntity>[];
//        return SelectOrCreatePlayerWidget(
//          players: players,
//          onPlayerSelected: (player) {
//            // context.read<PlayerBloc>().add(PlayerSelectedEvent(player));
//          },
//          onPlayer1NameChanged: (name) {
//            // context.read<PlayerBloc>().add(Player1NameChangedEvent(name));
//          },
//          onPlayer2NameChanged: (name) {
//            // context.read<PlayerBloc>().add(Player2NameChangedEvent(name));
//          },
//        );
//      },
//    );
//
// 2. Создание нового игрока через Bloc:
//    // context.read<PlayerBloc>().add(CreatePlayerEvent(name: player1Controller.text));
// ============================================================================

class SelectOrCreatePlayerWidget extends StatelessWidget {
  /// Список существующих игроков (PlayerEntity)
  final List<PlayerEntity> players;

  /// Множество выбранных игроков
  final Set<PlayerEntity> selectedPlayers;

  /// Коллбэк при выборе игрока из списка
  final ValueChanged<PlayerEntity>? onPlayerSelected;

  /// Контроллер для ввода имени нового игрока 1
  final TextEditingController? player1Controller;

  /// Контроллер для ввода имени нового игрока 2
  final TextEditingController? player2Controller;

  /// Коллбэк при изменении имени игрока 1
  final ValueChanged<String>? onPlayer1NameChanged;

  /// Коллбэк при изменении имени игрока 2
  final ValueChanged<String>? onPlayer2NameChanged;

  /// Коллбэк при очистке имени игрока 1
  final VoidCallback? onClearPlayer1;

  /// Коллбэк при очистке имени игрока 2
  final VoidCallback? onClearPlayer2;

  const SelectOrCreatePlayerWidget({
    super.key,
    this.players = const [],
    this.selectedPlayers = const {},
    this.onPlayerSelected,
    this.player1Controller,
    this.player2Controller,
    this.onPlayer1NameChanged,
    this.onPlayer2NameChanged,
    this.onClearPlayer1,
    this.onClearPlayer2,
  });

  bool _isPlayerAlreadySelected(PlayerEntity player) {
    final p1Text = player1Controller?.text.trim().toLowerCase() ?? '';
    final p2Text = player2Controller?.text.trim().toLowerCase() ?? '';
    final targetName = player.name.trim().toLowerCase();

    final matchesController =
        (p1Text.isNotEmpty && p1Text == targetName) ||
        (p2Text.isNotEmpty && p2Text == targetName);

    final inSelectedSet = selectedPlayers.any(
      (p) =>
          identical(p, player) ||
          (p.id != null && player.id != null && p.id == player.id) ||
          p.name.trim().toLowerCase() == targetName,
    );

    return matchesController || inSelectedSet;
  }

  void _showPlayersDialog(BuildContext context) {
    final isP1Filled = player1Controller?.text.trim().isNotEmpty ?? false;
    final isP2Filled = player2Controller?.text.trim().isNotEmpty ?? false;
    if (players.isEmpty || (isP1Filled && isP2Filled)) return;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.people_alt_rounded, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Select Player',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(sheetContext).size.height * 0.45,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: players.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final player = players[index];
                      final isSelected = _isPlayerAlreadySelected(player);

                      return ListTile(
                        enabled: !isSelected,
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? colorScheme.surfaceContainerHighest
                              : colorScheme.primaryContainer,
                          foregroundColor: isSelected
                              ? theme.disabledColor
                              : colorScheme.onPrimaryContainer,
                          child: Text(
                            player.name.isNotEmpty
                                ? player.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          player.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isSelected ? theme.disabledColor : null,
                          ),
                        ),
                        subtitle: Text(
                          isSelected
                              ? 'Already selected'
                              : 'Games: ${player.games} | Wins: ${player.wins} | Losses: ${player.losses} | Draws: ${player.draws}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? theme.disabledColor
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: colorScheme.primary)
                            : null,
                        onTap: isSelected
                            ? null
                            : () {
                                Navigator.of(sheetContext).pop();
                                onPlayerSelected?.call(player);
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasPlayers = players.isNotEmpty;

    final controllersListenable = Listenable.merge([
      ?player1Controller,
      ?player2Controller,
    ]);

    return AnimatedBuilder(
      animation: controllersListenable,
      builder: (context, _) {
        final isP1Filled = player1Controller?.text.trim().isNotEmpty ?? false;
        final isP2Filled = player2Controller?.text.trim().isNotEmpty ?? false;
        final isBothPlayersFilled = isP1Filled && isP2Filled;
        final canSelect = hasPlayers && !isBothPlayersFilled;

        String subtitleText;
        if (!hasPlayers) {
          subtitleText = 'Player list is empty';
        } else if (isBothPlayersFilled) {
          subtitleText = 'Both players selected';
        } else if (!isP1Filled) {
          subtitleText = 'Select Player 1 (${players.length} available)';
        } else {
          subtitleText = 'Select Player 2 (${players.length} available)';
        }

        return GridSectionCard(
          icon: Icons.group_rounded,
          title: 'Players',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==================================================================
              // ЭЛЕМЕНТ 1: Выбор игрока из списка игроков (PlayerEntity).
              // Если список пуст или оба игрока заполнены: элемент отключен.
              // Иначе: при нажатии открывается список игроков.
              // ==================================================================
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: canSelect ? () => _showPlayersDialog(context) : null,
                  borderRadius: BorderRadius.circular(14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: canSelect
                          ? colorScheme.surface
                          : colorScheme.surfaceContainerHighest.withAlpha(90),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: canSelect
                            ? colorScheme.outlineVariant.withAlpha(80)
                            : colorScheme.outlineVariant.withAlpha(40),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          !hasPlayers
                              ? Icons.person_off_outlined
                              : isBothPlayersFilled
                                  ? Icons.group_outlined
                                  : Icons.person_search_rounded,
                          size: 24,
                          color: canSelect
                              ? colorScheme.primary
                              : theme.disabledColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select existing player',
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: canSelect
                                      ? colorScheme.onSurface
                                      : theme.disabledColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                subtitleText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: canSelect
                                      ? colorScheme.onSurfaceVariant
                                      : theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: canSelect
                              ? colorScheme.onSurfaceVariant
                              : theme.disabledColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ==================================================================
              // ЭЛЕМЕНТ 2: Ввод имени нового игрока 1 (Player 1 / X)
              // ==================================================================
              TextField(
                controller: player1Controller,
                onChanged: (text) {
                  onPlayer1NameChanged?.call(text);
                },
                decoration: InputDecoration(
                  labelText: 'New Player 1 Name (X)',
                  hintText: 'Enter name for Player 1',
                  prefixIcon: Icon(Icons.person, color: colorScheme.primary),
                  suffixIcon: (player1Controller?.text.isNotEmpty ?? false)
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 20),
                          tooltip: 'Clear',
                          onPressed: () {
                            player1Controller?.clear();
                            onClearPlayer1?.call();
                            onPlayer1NameChanged?.call('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ==================================================================
              // ЭЛЕМЕНТ 3: Ввод имени нового игрока 2 (Player 2 / O)
              // ==================================================================
              TextField(
                controller: player2Controller,
                onChanged: (text) {
                  onPlayer2NameChanged?.call(text);
                },
                decoration: InputDecoration(
                  labelText: 'New Player 2 Name (O)',
                  hintText: 'Enter name for Player 2',
                  prefixIcon: Icon(Icons.person_outline, color: colorScheme.secondary),
                  suffixIcon: (player2Controller?.text.isNotEmpty ?? false)
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 20),
                          tooltip: 'Clear',
                          onPressed: () {
                            player2Controller?.clear();
                            onClearPlayer2?.call();
                            onPlayer2NameChanged?.call('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.secondary, width: 1.6),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
