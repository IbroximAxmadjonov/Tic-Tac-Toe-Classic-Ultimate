import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/widgets/main/create_player_main_widget.dart';

import '../../../domain/constants/enums.dart';
import '../../manager/main_bloc/main_bloc.dart';
import '../../widgets/main/saving_game_widget.dart';
import '../../widgets/main/select_player_main_widget.dart';
import '../../widgets/main/widgets.dart';

class MainInitialView extends StatelessWidget {
  const MainInitialView({super.key, required this.state});

  final MainInitialState state;

  /// Валидация перед запуском игры.
  bool _canStart() {
    if (state.saveGame == SaveGame.no) return true;
    return state.selectedPlayerX != null && state.selectedPlayerO != null;
  }

  void _onStartPressed(BuildContext context) {
    if (!_canStart()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select both players before starting the game.'),
        ),
      );
      return;
    }

    context.read<MainBloc>().add(
      StartGameMainEvent(
        gameMode: state.gameMode,
        selectedSize: state.selectedSize,
        saveGame: state.saveGame,
        // При saveGame == no передаём дефолтных гостевых игроков.
        playerX: state.selectedPlayerX,
        playerO: state.selectedPlayerO,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GridHeaderTitle(),
              const SizedBox(height: 20),

              // ── Select Mode ──────────────────────────────────────────────
              GridModeSelector(
                selectedMode: state.gameMode,
                onModeChanged: (mode) {
                  context.read<MainBloc>().add(
                    ChangeMainInitialElementsMainEvent(object: mode),
                  );
                },
              ),
              GridSizeSelector(
                isVisible:
                    state.gameMode == GameMode.expanded ||
                    state.gameMode == GameMode.threeInARow,
                selectedSize: state.selectedSize,
                onSizeChanged: (size) {
                  context.read<MainBloc>().add(
                    ChangeMainInitialElementsMainEvent(object: size),
                  );
                },
              ),
              const SizedBox(height: 20),

              // ── Save Game ────────────────────────────────────────────────
              SavingGameWidget(
                selectedSaveGame: state.saveGame,
                onSaveGameChanged: (saveGame) {
                  context.read<MainBloc>().add(
                    ChangeMainInitialElementsMainEvent(object: saveGame),
                  );
                },
              ),

              // ── Players (появляется только при SaveGame.yes) ─────────────
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: state.saveGame == SaveGame.yes
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GridSectionCard(
                    icon: Icons.group_rounded,
                    title: 'Players',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Player 1 (X) ─────────────────────────────────
                        SelectPlayerMainWidget(
                          players: state.players,
                          player: state.selectedPlayerX,
                          otherPlayer: state.selectedPlayerO,
                          playerSymbol: PlayerSymbol.x,
                          onPlayerSelected: (player) {
                            context.read<MainBloc>().add(
                              AddPlayerToMainEvent(
                                playerSymbol: PlayerSymbol.x,
                                player: player,
                              ),
                            );
                          },
                          onPlayerCleared: () {
                            context.read<MainBloc>().add(
                              ClearPlayerMainEvent(playerSymbol: PlayerSymbol.x),
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // ── Player 2 (O) ─────────────────────────────────
                        SelectPlayerMainWidget(
                          players: state.players,
                          player: state.selectedPlayerO,
                          otherPlayer: state.selectedPlayerX,
                          playerSymbol: PlayerSymbol.o,
                          onPlayerSelected: (player) {
                            context.read<MainBloc>().add(
                              AddPlayerToMainEvent(
                                playerSymbol: PlayerSymbol.o,
                                player: player,
                              ),
                            );
                          },
                          onPlayerCleared: () {
                            context.read<MainBloc>().add(
                              ClearPlayerMainEvent(playerSymbol: PlayerSymbol.o),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        const SizedBox(height: 10),
                        // ── Create a new player ──────────────────────────
                        CreatePlayerMainWidget(),
                      ],
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),

              // ── Start Button ─────────────────────────────────────────────
              GridStartButton(onPressed: () => _onStartPressed(context)),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
