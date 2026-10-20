part of 'main_bloc.dart';

abstract class MainState extends Equatable {}

class MainInitialState extends MainState {
  final List<PlayerEntity> players;
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;

  MainInitialState({
    required this.players,
    required this.gameMode,
    required this.selectedSize,
    required this.saveGame,
  });

  @override
  List<Object?> get props => [players, gameMode, selectedSize, saveGame];

  MainInitialState copyWith({
    List<PlayerEntity>? players,
    GameMode? gameMode,
    int? selectedSize,
    SaveGame? saveGame,
  }) {
    return MainInitialState(
      players: players ?? this.players,
      gameMode: gameMode ?? this.gameMode,
      selectedSize: selectedSize ?? this.selectedSize,
      saveGame: saveGame ?? this.saveGame,
    );
  }
}

class MainPlayingState extends MainState {
  final GridItemsEntity gridItems;
  final GameStateEntity gameState;
  // final int playerAId;
  // final int playerBId;

  MainPlayingState({
    required this.gridItems,
    required this.gameState,
    // required this.playerAId,
    // required this.playerBId,
  });

  MainPlayingState copyWith({
    GridItemsEntity? gridItems,
    GameStateEntity? gameState,
    // int? playerAId,
    // int? playerBId,
  }) {
    return MainPlayingState(
      gridItems: gridItems ?? this.gridItems,
      gameState: gameState ?? this.gameState,
      // playerAId: playerAId ?? this.playerAId,
      // playerBId: playerBId ?? this.playerBId,
    );
  }

  @override
  List<Object?> get props => [gridItems, gameState, ];
}

class MainFinishedState extends MainState {
  final GameStateEntity gameState;
  final GridItemsEntity gameGridItems;

  MainFinishedState({required this.gameState, required this.gameGridItems});

  @override
  List<Object?> get props => [gameState, gameGridItems];
}
