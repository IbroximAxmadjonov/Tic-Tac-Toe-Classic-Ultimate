import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/manager/main_bloc/main_bloc.dart';
import 'grid_before_the_game_starts_view.dart';
import 'grid_finish_the_game_view.dart';
import 'grid_playing_view.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainInitialState) return GridBeforeTheGameStartsView(state: state);
          if (state is MainPlayingState) return GridPlayingView(state: state);
          if (state is MainFinishedState) return GridFinishTheGameView(state: state);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
