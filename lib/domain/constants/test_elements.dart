import 'package:tic_tac_toe/presentation/manager/main_bloc/main_bloc.dart';

import '../entities/player_entity.dart';
import 'enums.dart';

final testForMainInitialState = MainInitialState(
  players: [
    PlayerEntity(id: 0, name: 'Player 1', games: 0, wins: 0, losses: 0, draws: 0),
    PlayerEntity(id: 1, name: 'Player 2', games: 0, wins: 0, losses: 0, draws: 0),
    PlayerEntity(id: 2, name: 'Player 3', games: 0, wins: 0, losses: 0, draws: 0),
    PlayerEntity(id: 3, name: 'Player 4', games: 0, wins: 0, losses: 0, draws: 0),
    PlayerEntity(id: 4, name: 'Player 5', games: 0, wins: 0, losses: 0, draws: 0),
  ],
  gameMode: GameMode.classic,
  selectedSize: 4,
  saveGame: SaveGame.no,
);
