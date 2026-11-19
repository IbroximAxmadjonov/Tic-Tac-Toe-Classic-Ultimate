import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../manager/home_bloc/home_bloc.dart';
import '../../widgets/widgets.dart';

class SetupHomeView extends StatelessWidget {
  const SetupHomeView({super.key, required this.state});

  final HomeSetupState state;

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

    context.read<HomeBloc>().add(
      StartGameHomeEvent(
        gameMode: state.gameMode,
        selectedSize: state.selectedSize,
        saveGame: state.saveGame,
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
              const HomeHeaderTitleWidget(),
              const SizedBox(height: 20),

              // ── Select Mode ──────────────────────────────────────────────
              ModeSelectorWidget(
                selectedMode: state.gameMode,
                onModeChanged: (mode) {
                  context.read<HomeBloc>().add(
                    ChangeGameModeHomeEvent(gameMode: mode),
                  );
                },
              ),
              GridSizeSelectorWidget(
                isVisible:
                    state.gameMode == GameMode.expanded ||
                    state.gameMode == GameMode.threeInARow,
                selectedSize: state.selectedSize,
                onSizeChanged: (size) {
                  context.read<HomeBloc>().add(
                    ChangeSelectedSizeHomeEvent(selectedSize: size),
                  );
                },
              ),
              const SizedBox(height: 20),

              // ── Save Game ────────────────────────────────────────────────
              SavingGameWidget(
                selectedSaveGame: state.saveGame,
                onSaveGameChanged: (saveGame) {
                  context.read<HomeBloc>().add(
                    ChangeSaveGameHomeEvent(saveGame: saveGame),
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
                  child: SectionCard(
                    icon: Icons.group_rounded,
                    title: 'Players',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Player 1 (X) ─────────────────────────────────
                        SelectPlayerWidget(
                          players: state.playersList,
                          player: state.selectedPlayerX,
                          otherPlayer: state.selectedPlayerO,
                          playerSymbol: PlayerSymbol.x,
                          onPlayerSelected: (player) {
                            context.read<HomeBloc>().add(
                              AddPlayerToHomeEvent(
                                playerSymbol: PlayerSymbol.x,
                                player: player,
                              ),
                            );
                          },
                          onPlayerCleared: () {
                            context.read<HomeBloc>().add(
                              ClearPlayerHomeEvent(
                                playerSymbol: PlayerSymbol.x,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // ── Player 2 (O) ─────────────────────────────────
                        SelectPlayerWidget(
                          players: state.playersList,
                          player: state.selectedPlayerO,
                          otherPlayer: state.selectedPlayerX,
                          playerSymbol: PlayerSymbol.o,
                          onPlayerSelected: (player) {
                            context.read<HomeBloc>().add(
                              AddPlayerToHomeEvent(
                                playerSymbol: PlayerSymbol.o,
                                player: player,
                              ),
                            );
                          },
                          onPlayerCleared: () {
                            context.read<HomeBloc>().add(
                              ClearPlayerHomeEvent(
                                playerSymbol: PlayerSymbol.o,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        const Divider(),
                        const SizedBox(height: 10),
                        // ── Create a new player ──────────────────────────
                        CreatePlayerWidget(
                          onPlayerCreated: (name) {
                            context.read<HomeBloc>().add(
                              CreatePlayerHomeEvent(name: name),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),

              // ── Start Button ─────────────────────────────────────────────
              StartButton(onPressed: () => _onStartPressed(context)),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
