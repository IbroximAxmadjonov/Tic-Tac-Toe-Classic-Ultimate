part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSetupState extends HomeState {
  final List<PlayerEntity> players;
  final List<PlayerPairEntity> playerPairs;
  final List<GameSessionEntity> selectedPairSessions;
  final PlayerEntity? lastFetchedPlayer;
  final PlayerEntity? selectedPlayerX;
  final PlayerEntity? selectedPlayerO;
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;

  HomeSetupState({
    required this.players,
    this.playerPairs = const [],
    this.selectedPairSessions = const [],
    this.lastFetchedPlayer,
    this.selectedPlayerX,
    this.selectedPlayerO,
    required this.gameMode,
    required this.selectedSize,
    this.saveGame = SaveGame.no,
  });

  @override
  List<Object?> get props => [
    players,
    playerPairs,
    selectedPairSessions,
    lastFetchedPlayer,
    selectedPlayerX,
    selectedPlayerO,
    gameMode,
    selectedSize,
    saveGame,
  ];

  HomeSetupState copyWith({
    List<PlayerEntity>? players,
    List<PlayerPairEntity>? playerPairs,
    List<GameSessionEntity>? selectedPairSessions,
    PlayerEntity? lastFetchedPlayer,
    PlayerEntity? selectedPlayerX,
    bool clearPlayerX = false,
    PlayerEntity? selectedPlayerO,
    bool clearPlayerO = false,
    GameMode? gameMode,
    int? selectedSize,
    SaveGame? saveGame,
  }) {
    return HomeSetupState(
      players: players ?? this.players,
      playerPairs: playerPairs ?? this.playerPairs,
      selectedPairSessions: selectedPairSessions ?? this.selectedPairSessions,
      lastFetchedPlayer: lastFetchedPlayer ?? this.lastFetchedPlayer,
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

class HomePlayingState extends HomeState {
  final GridItemsEntity gridItems;
  final GameStateEntity gameState;

  final PlayerEntity playerX;
  final PlayerEntity playerO;

  HomePlayingState({
    required this.gridItems,
    required this.gameState,
    required this.playerX,
    required this.playerO,
  });

  HomePlayingState copyWith({
    GridItemsEntity? gridItems,
    GameStateEntity? gameState,
    PlayerEntity? playerX,
    PlayerEntity? playerO,
  }) {
    return HomePlayingState(
      gridItems: gridItems ?? this.gridItems,
      gameState: gameState ?? this.gameState,
      playerX: playerX ?? this.playerX,
      playerO: playerO ?? this.playerO,
    );
  }

  @override
  List<Object?> get props => [gridItems, gameState, playerX, playerO];
}

class HomeFinishedState extends HomeState {
  final GameStateEntity gameState;
  final GridItemsEntity gameGridItems;
  final PlayerEntity? winnerPlayer;
  final PlayerEntity playerX;
  final PlayerEntity playerO;

  HomeFinishedState({
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
