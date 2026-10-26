import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presentation/widgets/main/grid_tile_widget.dart';

import '../../../domain/constants/enums.dart';
import 'grid_section_card.dart';

class GridModeSelector extends StatelessWidget {
  final GameMode selectedMode;
  final ValueChanged<GameMode> onModeChanged;

  const GridModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridSectionCard(
      icon: Icons.tune_rounded,
      title: 'Select Mode',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GridTileWidget(
                  value: GameMode.classic,
                  title: 'Classic',
                  isSelected: selectedMode == GameMode.classic,
                  onSelected: (value) {
                    onModeChanged(value as GameMode);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridTileWidget(
                  value: GameMode.ultimate,
                  title: 'Ultimate',
                  isSelected: selectedMode == GameMode.ultimate,
                  onSelected: (value) {
                    onModeChanged(value as GameMode);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GridTileWidget(
                  value: GameMode.expanded,
                  title: 'Expanded',
                  isSelected: selectedMode == GameMode.expanded,
                  onSelected: (value) {
                    onModeChanged(value as GameMode);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridTileWidget(
                  value: GameMode.threeInARow,
                  title: 'Three in a row',
                  isSelected: selectedMode == GameMode.threeInARow,
                  onSelected: (value) {
                    onModeChanged(value as GameMode);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
