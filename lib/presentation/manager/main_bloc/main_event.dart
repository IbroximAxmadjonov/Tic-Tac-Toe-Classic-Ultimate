part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class LoadMainEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}

class ChangeMainInitialElementsMainEvent extends MainEvent {
  final Object object;

  ChangeMainInitialElementsMainEvent({required this.object});

  @override
  List<Object?> get props => [object];
}

class AddPlayerToMainEvent extends MainEvent {
  final PlayerSymbol playerSymbol;
  final PlayerEntity player;

  AddPlayerToMainEvent({required this.playerSymbol, required this.player});

  @override
  List<Object?> get props => [playerSymbol, player];
}

/// Создаёт нового игрока в БД и обновляет список игроков в состоянии.
class CreatePlayerMainEvent extends MainEvent {
  final String name;

  CreatePlayerMainEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

/// Очищает выбранного игрока в слоте 1 (playerSymbol == PlayerSymbol.x) или 2 (playerSymbol == PlayerSymbol.o).
class ClearPlayerMainEvent extends MainEvent {
  final PlayerSymbol playerSymbol;

  ClearPlayerMainEvent({required this.playerSymbol});

  @override
  List<Object?> get props => [playerSymbol];
}

class StartGameMainEvent extends MainEvent {
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;
  final PlayerEntity? playerX;
  final PlayerEntity? playerO;

  StartGameMainEvent({
    required this.gameMode,
    required this.selectedSize,
    required this.saveGame,
    required this.playerX,
    required this.playerO,
  });

  @override
  List<Object?> get props => [gameMode, selectedSize, saveGame, playerX, playerO];
}

/// In MainPlayingState:
class TappedOnMainEvent extends MainEvent {
  final int indexOfBigGrid;
  final int indexOfSmallGrid;

  TappedOnMainEvent({required this.indexOfBigGrid, required this.indexOfSmallGrid});

  @override
  List<Object?> get props => [indexOfBigGrid, indexOfSmallGrid];
}

class RestartGameMainEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}

class ExitGameMainEvent extends MainEvent {
  // final int player1Id;
  // final int player2Id;
  // final int? winnerPlayerId;
  // final GameMode mode;
  // final SaveGame saveGame;

  ExitGameMainEvent(
      // {
    // required this.player1Id,
    // required this.player2Id,
    // required this.winnerPlayerId,
    // required this.mode,
    // required this.saveGame,
  // }
  );

  @override
  List<Object?> get props => [
    // player1Id, player2Id, winnerPlayerId, mode, saveGame
  ];
}

/// In MainFinishedState:

class FinishAndRestartGameMainEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}

class FinishAndExitGameMainEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}


// class SaveGameMainEvent extends MainEvent {
//   final int player1Id;
//   final int player2Id;
//   final int? winnerPlayerId;
//   final GameMode mode;
//
//   SaveGameMainEvent({
//     required this.player1Id,
//     required this.player2Id,
//     required this.winnerPlayerId,
//     required this.mode,
//   });
//
//   @override
//   List<Object?> get props => [player1Id, player2Id, winnerPlayerId, mode];
// }
