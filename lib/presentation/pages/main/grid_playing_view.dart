import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/manager/main_bloc/main_bloc.dart';
import 'package:tic_tac_toe/presentation/pages/main/grid_grid_view.dart';

import '../../widgets/main/widgets.dart';

class GridPlayingView extends StatelessWidget {
  final MainPlayingState state;

  const GridPlayingView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gridItems = state.gridItems;
    final gameState = state.gameState;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Заголовок ──────────────────────────────────────────────────
            // const GridHeaderTitle(),
            // const SizedBox(height: 16),

            // ── Статус игры ────────────────────────────────────────────────
            GridSectionCard(
              icon: Icons.person_rounded,
              title: 'Статус игры',
              child: Row(
                children: [
                  // Текущий игрок
                  Expanded(
                    child: _StatChip(
                      icon: Icons.sports_esports_rounded,
                      label: 'Ходит',
                      value: gameState.currentPlayer.name.toUpperCase(),
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Счётчик ходов
                  Expanded(
                    child: _StatChip(
                      icon: Icons.tag_rounded,
                      label: 'Ходов',
                      value: '${gameState.moveCount}',
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Игровое поле ───────────────────────────────────────────────
            GridSectionCard(
              icon: Icons.grid_on_rounded,
              title: 'Игровое поле',
              child: GridGridView(
                gridItems: gridItems,
                permissionBigGridItems: gameState.permissibleBigGrid,
              ),
            ),
            const SizedBox(height: 20),

            // ── Кнопки управления ──────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<MainBloc>().add(RestartGameMainEvent());
                },
                icon: const Icon(Icons.replay_rounded, size: 22),
                label: const Text(
                  'Restart Game',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<MainBloc>().add(
                    ResetToMenuMainEvent(
                      // playerAId: state.playerAId,
                      // playerBId: state.playerBId,
                      // winnerPlayerId: winnerPlayerId,
                      // mode: state.gameState.gameMode,
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 22,
                  color: colorScheme.onSurface,
                ),
                label: Text(
                  'Reset to Menu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colorScheme.outlineVariant, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Вспомогательный виджет — карточка-чип для отображения статистики
class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
