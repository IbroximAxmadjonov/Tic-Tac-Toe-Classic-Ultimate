import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/domain/constants/enums.dart';
import 'grid_mode_tile.dart';
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
                child: GridModeTile(
                  mode: GameMode.classic,
                  title: 'Classic',
                  icon: Icons.grid_3x3_rounded,
                  isSelected: selectedMode == GameMode.classic,
                  onSelected: onModeChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridModeTile(
                  mode: GameMode.ultimate,
                  title: 'Ultimate',
                  icon: Icons.grid_view_rounded,
                  isSelected: selectedMode == GameMode.ultimate,
                  onSelected: onModeChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GridModeTile(
                  mode: GameMode.expanded,
                  title: 'Expanded',
                  icon: Icons.fullscreen_rounded,
                  isSelected: selectedMode == GameMode.expanded,
                  onSelected: onModeChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridModeTile(
                  mode: GameMode.threeInARow,
                  title: 'Three in a row',
                  icon: Icons.linear_scale_rounded,
                  isSelected: selectedMode == GameMode.threeInARow,
                  onSelected: onModeChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
