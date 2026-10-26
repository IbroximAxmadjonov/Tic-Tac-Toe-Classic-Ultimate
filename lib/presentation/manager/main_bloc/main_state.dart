part of 'main_bloc.dart';

abstract class MainState extends Equatable {}

class MainInitialState extends MainState {
  final List<PlayerEntity> players;
  final PlayerEntity? selectedPlayerX;
  final PlayerEntity? selectedPlayerO;
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;

  MainInitialState({
    required this.players,
    this.selectedPlayerX,
    this.selectedPlayerO,
    required this.gameMode,
    required this.selectedSize,
    required this.saveGame,
  });

  @override
  List<Object?> get props => [
    players,
    selectedPlayerX,
    selectedPlayerO,
    gameMode,
    selectedSize,
    saveGame,
  ];

  // Используем Object? sentinel для явного сброса в null через copyWith.
  // Передай clearPlayerA: true, чтобы обнулить selectedPlayerA.
  MainInitialState copyWith({
    List<PlayerEntity>? players,
    PlayerEntity? selectedPlayerX,
    bool clearPlayerX = false,
    PlayerEntity? selectedPlayerO,
    bool clearPlayerO = false,
    GameMode? gameMode,
    int? selectedSize,
    SaveGame? saveGame,
  }) {
    return MainInitialState(
      players: players ?? this.players,
      selectedPlayerX: clearPlayerX
          ? null
          : (selectedPlayerX ?? this.selectedPlayerX),
      selectedPlayerO: clearPlayerO
          ? null
          : (selectedPlayerO ?? this.selectedPlayerO),
      gameMode: gameMode ?? this.gameMode,
      selectedSize: selectedSize ?? this.selectedSize,
      saveGame: saveGame ?? this.saveGame,
    );
  }
}

class MainPlayingState extends MainState {
  final GridItemsEntity gridItems;
  final GameStateEntity gameState;

  final PlayerEntity playerX;
  final PlayerEntity playerO;

  MainPlayingState({
    required this.gridItems,
    required this.gameState,
    required this.playerX,
    required this.playerO,
  });

  MainPlayingState copyWith({
    GridItemsEntity? gridItems,
    GameStateEntity? gameState,
    PlayerEntity? playerX,
    PlayerEntity? playerO,
  }) {
    return MainPlayingState(
      gridItems: gridItems ?? this.gridItems,
      gameState: gameState ?? this.gameState,
      playerX: playerX ?? this.playerX,
      playerO: playerO ?? this.playerO,
    );
  }

  @override
  List<Object?> get props => [gridItems, gameState, playerX, playerO];
}

class MainFinishedState extends MainState {
  final GameStateEntity gameState;
  final GridItemsEntity gameGridItems;
  final PlayerEntity winnerPlayer;
  final PlayerEntity playerX;
  final PlayerEntity playerO;

  MainFinishedState({
    required this.gameState,
    required this.gameGridItems,
    required this.winnerPlayer,
    required this.playerX,
    required this.playerO,
  });

  @override
  List<Object?> get props => [
    gameState,
    gameGridItems,
    winnerPlayer,
    playerX,
    playerO,
  ];
}
