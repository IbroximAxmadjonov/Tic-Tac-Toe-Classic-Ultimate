import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/manager/home_bloc/home_bloc.dart';

class GameOverHomeView extends StatelessWidget {
  final HomeFinishedState state;

  const GameOverHomeView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.winnerPlayer != null
                  ? 'Победил ${state.winnerPlayer!.name}'
                  : 'Ничья!',
            ),
            const SizedBox(height: 20),
            Text('Ходов ${state.gameState.moveCount}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(FinishAndRestartGameHomeEvent());
              },
              child: const Text('Restart Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(FinishAndExitGameHomeEvent());
              },
              child: const Text('Reset to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
