import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/grid/presentation/manager/grid_block.dart';
import 'grid_before_the_game_starts_view.dart';
import 'grid_playing_view.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Page')),
      body: BlocBuilder<GridBlock, GridState>(
        builder: (context, state) {
          if (state is GridBeforeTheGameStartsState) {
            return GridBeforeTheGameStartsView();
          }
          if (state is GridPlayingState) {
            return GridPlayingView(state: state);
          }
          if (state is GridFinishedState) {
            final gameState = state.gameState;
            return Card(
              elevation: 5,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Победил ${gameState.currentPlayer.name}'),
                  const SizedBox(height: 20),
                  Text('Ходов ${gameState.moveCount}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GridBlock>().add(RestartGameGridEvent());
                    },
                    child: const Text('Restart Game'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
