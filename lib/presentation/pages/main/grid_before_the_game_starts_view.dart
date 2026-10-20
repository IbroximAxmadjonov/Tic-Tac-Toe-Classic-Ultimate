import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../domain/entities/player_entity.dart';
import '../../manager/main_bloc/main_bloc.dart';
import '../../widgets/main/saving_game_widget.dart';
import '../../widgets/main/select_or_create_player_widget.dart';
import '../../widgets/main/widgets.dart';

class GridBeforeTheGameStartsView extends StatefulWidget {
  const GridBeforeTheGameStartsView({super.key, required this.state});

  final MainInitialState state;

  @override
  State<GridBeforeTheGameStartsView> createState() =>
      _GridBeforeTheGameStartsViewState();
}

class _GridBeforeTheGameStartsViewState extends State<GridBeforeTheGameStartsView> {
  // GameMode _selectedMode = GameMode.classic;
  // int _selectedSize = 4;
  SaveGame _selectedSaveGame = SaveGame.no;

  final Set<PlayerEntity> _selectedPlayers = {};
  PlayerEntity? _player1Selected;
  PlayerEntity? _player2Selected;
  late final TextEditingController _player1Controller;
  late final TextEditingController _player2Controller;

  // Список сохранённых игроков. В реальном сценарии передаётся или загружается из Bloc:
  // final List<PlayerEntity> _players = [];

  @override
  void initState() {
    super.initState();
    _player1Controller = TextEditingController();
    _player2Controller = TextEditingController();
    _player1Controller.addListener(_onControllersChanged);
    _player2Controller.addListener(_onControllersChanged);

    // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
    // // Загрузка списка игроков при инициализации:
    // // context.read<PlayerBloc>().add(LoadPlayersEvent());
  }

  void _onControllersChanged() {
    setState(() {
      _syncSelectedPlayers();
    });
  }

  void _syncSelectedPlayers() {
    if (_player1Controller.text.trim().isEmpty) {
      _player1Selected = null;
    } else if (_player1Selected != null &&
        _player1Selected!.name.trim().toLowerCase() !=
            _player1Controller.text.trim().toLowerCase()) {
      _player1Selected = null;
    }

    if (_player2Controller.text.trim().isEmpty) {
      _player2Selected = null;
    } else if (_player2Selected != null &&
        _player2Selected!.name.trim().toLowerCase() !=
            _player2Controller.text.trim().toLowerCase()) {
      _player2Selected = null;
    }

    _selectedPlayers.clear();
    if (_player1Selected != null) {
      _selectedPlayers.add(_player1Selected!);
    }
    if (_player2Selected != null) {
      _selectedPlayers.add(_player2Selected!);
    }
  }

  @override
  void dispose() {
    _player1Controller.removeListener(_onControllersChanged);
    _player2Controller.removeListener(_onControllersChanged);
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSizeSelector =
        widget.state.gameMode == GameMode.expanded ||
        widget.state.gameMode == GameMode.threeInARow;

    // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
    // // Если список игроков поступает из отдельного Bloc (например PlayerBloc):
    // // return BlocBuilder<PlayerBloc, PlayerState>(
    // //   builder: (context, playerState) {
    // //     final players = playerState is PlayersLoadedState
    // //         ? playerState.players
    // //         : <PlayerEntity>[];

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const GridHeaderTitle(),
                const SizedBox(height: 20),
                GridModeSelector(
                  selectedMode: widget.state.gameMode,
                  onModeChanged: (mode) {
                    // context.read<GridBlock>().add(ChangeGameModeEvent(mode));
                  },
                ),
                GridSizeSelector(
                  isVisible: showSizeSelector,
                  selectedSize: widget.state.selectedSize,
                  onSizeChanged: (size) {
                    // context.read<GridBlock>().add(ChangeSelectedSizeGameEvent(selectedSize))
                  },
                ),
                const SizedBox(height: 20),

                // 1) SavingGameWidget - переключатель сохранения игры (yes / no)
                SavingGameWidget(
                  // selectedSaveGame: widget.state.saveGame,
                  selectedSaveGame: _selectedSaveGame,
                  onSaveGameChanged: (saveGame) {
                    // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                    // // context.read<GridBlock>().add(ChangeSaveGameEvent(saveGame));
                    setState(() {
                      _selectedSaveGame = saveGame;
                    });
                  },
                ),

                // 2) SelectOrCreatePlayerWidget - появляется под SavingGameWidget только при выборе yes
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: _selectedSaveGame == SaveGame.yes
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SelectOrCreatePlayerWidget(
                      players: widget.state.players,
                      selectedPlayers: _selectedPlayers,
                      player1Controller: _player1Controller,
                      player2Controller: _player2Controller,
                      onPlayerSelected: (player) {
                        setState(() {
                          if (_player1Controller.text.trim().isEmpty) {
                            _player1Controller.text = player.name;
                            _player1Selected = player;
                          } else if (_player2Controller.text.trim().isEmpty) {
                            _player2Controller.text = player.name;
                            _player2Selected = player;
                          }
                          _syncSelectedPlayers();
                        });

                        // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                        // // context.read<GridBlock>().add(SelectPlayerEvent(player));
                      },
                      onPlayer1NameChanged: (name) {
                        setState(() {
                          _syncSelectedPlayers();
                        });
                        // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                        // // context.read<GridBlock>().add(UpdatePlayer1NameEvent(name));
                      },
                      onPlayer2NameChanged: (name) {
                        setState(() {
                          _syncSelectedPlayers();
                        });
                        // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                        // // context.read<GridBlock>().add(UpdatePlayer2NameEvent(name));
                      },
                      onClearPlayer1: () {
                        setState(() {
                          _player1Selected = null;
                          _syncSelectedPlayers();
                        });
                      },
                      onClearPlayer2: () {
                        setState(() {
                          _player2Selected = null;
                          _syncSelectedPlayers();
                        });
                      },
                    ),
                  ),
                  secondChild: const SizedBox.shrink(),
                ),

                const SizedBox(height: 20),
                GridStartButton(
                  onPressed: () {
                    // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
                    // // Если в StartGameGridEvent добавлены параметры сохранения и игроков:
                    // // context.read<GridBlock>().add(
                    // //   StartGameGridEvent(
                    // //     gameMode: _selectedMode,
                    // //     selectedSize: _selectedSize,
                    // //     saveGame: _selectedSaveGame,
                    // //     player1Name: _player1Controller.text.trim(),
                    // //     player2Name: _player2Controller.text.trim(),
                    // //     selectedPlayer: _selectedPlayer,
                    // //   ),
                    // // );

                    context.read<MainBloc>().add(
                      StartGameMainEvent(
                        gameMode: widget.state.gameMode,
                        selectedSize: widget.state.selectedSize,
                        saveGame: widget.state.saveGame,
                        // player1Name: _player1Controller.text.trim(),
                        // player2Name: _player2Controller.text.trim(),
                        // selectedPlayer: _selectedPlayer,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );

    // // --- BLOC INTEGRATION (TODO: connect with Bloc) ---
    // //   },
    // // );
  }
}
