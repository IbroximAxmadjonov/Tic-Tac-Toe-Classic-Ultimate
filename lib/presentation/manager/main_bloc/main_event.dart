part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class LoadMainEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}

class StartGameMainEvent extends MainEvent {
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;

  StartGameMainEvent({
    required this.gameMode,
    required this.selectedSize,
    required this.saveGame,
  });

  @override
  List<Object?> get props => [gameMode, selectedSize, saveGame];
}

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

class ResetToMenuMainEvent extends MainEvent {
  // final int playerAId;
  // final int playerBId;
  // final int? winnerPlayerId;
  // final GameMode mode;
  // final SaveGame saveGame;

  ResetToMenuMainEvent(
      // {
    // required this.playerAId,
    // required this.playerBId,
    // required this.winnerPlayerId,
    // required this.mode,
    // required this.saveGame,
  // }
  );

  @override
  List<Object?> get props => [
    // playerAId, playerBId, winnerPlayerId, mode, saveGame
  ];
}

class SaveGameMainEvent extends MainEvent {
  final int playerAId;
  final int playerBId;
  final int? winnerPlayerId;
  final GameMode mode;

  SaveGameMainEvent({
    required this.playerAId,
    required this.playerBId,
    required this.winnerPlayerId,
    required this.mode,
  });

  @override
  List<Object?> get props => [playerAId, playerBId, winnerPlayerId, mode];
}
