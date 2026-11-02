import 'package:flutter/material.dart';
import 'package:tic_tac_toe/generated/slang/slang.g.dart';

import '../../domain/constants/enums.dart';
import 'widgets.dart';

class ModeSelectorWidget extends StatelessWidget {
  final GameMode selectedMode;
  final ValueChanged<GameMode> onModeChanged;

  const ModeSelectorWidget({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.tune_rounded,
      title: context.t.settings.select_mode,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TileWidget(
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
                child: TileWidget(
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
                child: TileWidget(
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
                child: TileWidget(
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
