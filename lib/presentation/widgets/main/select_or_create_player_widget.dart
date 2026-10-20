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

  /// Текущий выбранный игрок из списка (если выбран)
  // final PlayerEntity? selectedPlayer;
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

  const SelectOrCreatePlayerWidget({
    super.key,
    this.players = const [],
    // this.selectedPlayer,
    this.selectedPlayers = const {},
    this.onPlayerSelected,
    this.player1Controller,
    this.player2Controller,
    this.onPlayer1NameChanged,
    this.onPlayer2NameChanged,
  });

  void _showPlayersDialog(BuildContext context) {
    if (players.isEmpty) return;

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

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.onPrimaryContainer,
                          child: Text(
                            player.name.isNotEmpty
                                ? player.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          player.name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Games: ${player.games} | Wins: ${player.wins} | Losses: ${player.losses} | Draws: ${player.draws}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        trailing: selectedPlayers.contains(player)
                            ? Icon(Icons.check_circle, color: colorScheme.primary)
                            : null,
                        onTap: () {
                          if (selectedPlayers.contains(player)) return;
                          Navigator.of(sheetContext).pop();
                          onPlayerSelected?.call(player);
                          selectedPlayers.add(player);

                          // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                          // // context.read<PlayerBloc>().add(SelectPlayerEvent(player));
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

    return GridSectionCard(
      icon: Icons.group_rounded,
      title: 'Players',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ==================================================================
          // ЭЛЕМЕНТ 1: Выбор игрока из списка игроков (PlayerEntity).
          // Если список пуст: цвет серый и элемент отключен.
          // Если список не пуст: при нажатии открывается список игроков.
          // ==================================================================
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: hasPlayers ? () => _showPlayersDialog(context) : null,
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: hasPlayers
                      ? colorScheme.surface
                      : colorScheme.surfaceContainerHighest.withAlpha(90),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withAlpha(80),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      hasPlayers
                          ? Icons.person_search_rounded
                          : Icons.person_off_outlined,
                      size: 24,
                      color: hasPlayers ? colorScheme.primary : theme.disabledColor,
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
                              color: hasPlayers
                                  ? colorScheme.onSurface
                                  : theme.disabledColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            hasPlayers
                                ? '${players.length} player(s) available'
                                : 'Player list is empty',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: hasPlayers
                                  ? colorScheme.onSurfaceVariant
                                  : theme.disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: hasPlayers
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
              // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
              // // context.read<PlayerBloc>().add(UpdatePlayer1NameEvent(text));
            },
            decoration: InputDecoration(
              labelText: 'New Player 1 Name (X)',
              hintText: 'Enter name for Player 1',
              prefixIcon: Icon(Icons.person, color: colorScheme.primary),
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
              // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
              // // context.read<PlayerBloc>().add(UpdatePlayer2NameEvent(text));
            },
            decoration: InputDecoration(
              labelText: 'New Player 2 Name (O)',
              hintText: 'Enter name for Player 2',
              prefixIcon: Icon(Icons.person_outline, color: colorScheme.secondary),
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
  }
}
