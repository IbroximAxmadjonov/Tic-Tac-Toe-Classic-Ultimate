import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/constants/enums.dart';

import '../../../domain/entities/player_entity.dart';
import '../../../utils/theme_extension.dart';

class SelectPlayerMainWidget extends StatelessWidget {
  const SelectPlayerMainWidget({
    super.key,
    required this.players,
    this.player,
    this.otherPlayer,
    required this.playerSymbol,
    required this.onPlayerSelected,
    this.onPlayerCleared,
  });

  final List<PlayerEntity> players;
  final PlayerEntity? player;

  // Игрок, выбранный в соседнем слоте — будет скрыт в диалоге выбора.
  final PlayerEntity? otherPlayer;
  final PlayerSymbol playerSymbol;
  final ValueChanged<PlayerEntity> onPlayerSelected;

  // Вызывается при нажатии кнопки сброса (галочка → стрелка).
  final VoidCallback? onPlayerCleared;

  bool _samePlayer(PlayerEntity a, PlayerEntity b) {
    if (identical(a, b)) return true;
    return a.id == b.id;
  }

  /// Возвращает true, если [p] уже занят в этом слоте или в соседнем.
  bool _isSelected(PlayerEntity p) {
    if (player != null && _samePlayer(p, player!)) return true;
    if (otherPlayer != null && _samePlayer(p, otherPlayer!)) return true;
    return false;
  }

  void _showPlayersDialog(
    BuildContext context, {
    required PlayerSymbol playerSymbol,
  }) {
    final availablePlayers = players
        .where((player) => !_isSelected(player))
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final colorScheme = theme.colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  playerSymbol == PlayerSymbol.x
                      ? 'Select Player 1 (X)'
                      : 'Select Player 2 (O)',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (availablePlayers.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'No available players. Create a new player below.',
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(sheetContext).size.height * 0.5,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: availablePlayers.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final player = availablePlayers[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: colorScheme.primaryContainer,
                            child: Text(
                              player.name.isNotEmpty
                                  ? player.name[0].toUpperCase()
                                  : '?',
                            ),
                          ),
                          title: Text(player.name),
                          subtitle: Text(
                            'Games: ${player.games} | '
                            'Wins: ${player.wins} | '
                            'Losses: ${player.losses} | '
                            'Draws: ${player.draws}',
                          ),
                          onTap: () {
                            Navigator.of(sheetContext).pop();
                            onPlayerSelected(player);
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
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _showPlayersDialog(context, playerSymbol: playerSymbol),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(
              Icons.person_rounded,
              color: playerSymbol == PlayerSymbol.x
                  ? context.colorScheme.primary
                  : context.colorScheme.secondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerSymbol == PlayerSymbol.x ? 'Player 1 (X)' : 'Player 2 (O)',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    player?.name ?? 'Select existing player',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (player != null)
              IconButton(
                tooltip: 'Remove player',
                onPressed: onPlayerCleared,
                icon: const Icon(Icons.person_remove),
              )
            else
              IconButton(
                tooltip: 'Add player',
                onPressed: () =>
                    _showPlayersDialog(context, playerSymbol: playerSymbol),
                icon: Icon(Icons.person_add),
              ),
          ],
        ),
      ),
    );
  }
}
