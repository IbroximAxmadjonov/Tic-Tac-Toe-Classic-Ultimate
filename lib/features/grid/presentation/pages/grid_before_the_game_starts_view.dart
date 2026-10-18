import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/domain/constants/enums.dart';
import 'package:tic_tac_toe/features/grid/presentation/manager/grid_block.dart';

import '../widgets/widgets.dart';

class GridBeforeTheGameStartsView extends StatefulWidget {
  const GridBeforeTheGameStartsView({super.key});

  @override
  State<GridBeforeTheGameStartsView> createState() =>
      _GridBeforeTheGameStartsViewState();
}

class _GridBeforeTheGameStartsViewState
    extends State<GridBeforeTheGameStartsView> {
  GameMode _selectedMode = GameMode.classic;
  int _selectedSize = 4;

  @override
  Widget build(BuildContext context) {
    final showSizeSelector =
        _selectedMode == GameMode.expanded ||
        _selectedMode == GameMode.threeInARow;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GridHeaderTitle(),
            const SizedBox(height: 20),
            GridModeSelector(
              selectedMode: _selectedMode,
              onModeChanged: (mode) => setState(() => _selectedMode = mode),
            ),
            GridSizeSelector(
              isVisible: showSizeSelector,
              selectedSize: _selectedSize,
              onSizeChanged: (size) => setState(() => _selectedSize = size),
            ),
            const SizedBox(height: 20),
            GridStartButton(
              onPressed: () {
                context.read<GridBlock>().add(
                  StartGameGridEvent(
                    gameMode: _selectedMode,
                    selectedSize: _selectedSize,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
