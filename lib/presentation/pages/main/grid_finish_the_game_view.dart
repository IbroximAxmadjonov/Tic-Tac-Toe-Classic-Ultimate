import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/manager/main_bloc/main_bloc.dart';

class GridFinishTheGameView extends StatelessWidget {
  final MainFinishedState state;

  const GridFinishTheGameView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Победил ${state.gameState.currentPlayer.name}'),
          const SizedBox(height: 20),
          Text('Ходов ${state.gameState.moveCount}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<MainBloc>().add(RestartGameMainEvent());
            },
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
