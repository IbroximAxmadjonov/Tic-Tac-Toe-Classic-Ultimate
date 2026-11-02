import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/home_bloc/home_bloc.dart';
import 'game_over_home_view.dart';
import 'playing_home_view.dart';
import 'setup_home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSetupState) return SetupHomeView(state: state);
          if (state is HomePlayingState) return PlayingHomeView(state: state);
          if (state is HomeFinishedState) return GameOverHomeView(state: state);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
