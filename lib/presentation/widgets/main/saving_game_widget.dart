import 'package:flutter/material.dart';

import '../../../domain/constants/enums.dart';
import '../../widgets/main/grid_section_card.dart';

// ============================================================================
// BLOC INTEGRATION NOTES (TODO: connect with Bloc)
// ============================================================================
// 1. Вы можете обернуть этот виджет или связать с BlocBuilder/BlocSelector:
//    BlocBuilder<GridBlock, GridState>(
//      builder: (context, state) {
//        final saveGame = state.saveGameOption; // ваш параметр из state
//        return SavingGameWidget(
//          selectedSaveGame: saveGame,
//          onSaveGameChanged: (val) {
//            context.read<GridBlock>().add(ChangeSaveGameOptionEvent(val));
//          },
//        );
//      },
//    );
// ============================================================================

class SavingGameWidget extends StatelessWidget {
  final SaveGame selectedSaveGame;
  final ValueChanged<SaveGame> onSaveGameChanged;

  const SavingGameWidget({
    super.key,
    required this.selectedSaveGame,
    required this.onSaveGameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridSectionCard(
      icon: Icons.bookmark_border_rounded,
      title: 'Save Game',
      child: Row(
        children: [
          Expanded(
            child: _SaveGameTile(
              label: 'No',
              icon: Icons.close_rounded,
              value: SaveGame.no,
              isSelected: selectedSaveGame == SaveGame.no,
              onSelected: (val) {
                onSaveGameChanged(val);
                // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                // // context.read<GridBlock>().add(ChangeSaveGameEvent(val));
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SaveGameTile(
              label: 'Yes',
              icon: Icons.check_rounded,
              value: SaveGame.yes,
              isSelected: selectedSaveGame == SaveGame.yes,
              onSelected: (val) {
                onSaveGameChanged(val);
                // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                // // context.read<GridBlock>().add(ChangeSaveGameEvent(val));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveGameTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final SaveGame value;
  final bool isSelected;
  final ValueChanged<SaveGame> onSelected;

  const _SaveGameTile({
    required this.label,
    required this.icon,
    required this.value,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(value),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary : colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
              width: isSelected ? 1.6 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
