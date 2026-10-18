part of 'grid_block.dart';

abstract class GridEvent extends Equatable {}

class StartGameGridEvent extends GridEvent {
  // final GameGridItemsEntity gameGridItems;
  // final GameSessionEntity gameSession;
  // final GameStateEntity gameState;
  //
  // StartGameGridEvent({required this.gameGridItems, required this.gameSession, required this.gameState});
  //
  // @override
  // List<Object?> get props => [gameGridItems, gameSession, gameState];

  final GameMode gameMode;
  final int selectedSize;

  StartGameGridEvent({required this.gameMode, required this.selectedSize});

  @override
  List<Object?> get props => [gameMode, selectedSize];

}

class TappedOnGridEvent extends GridEvent {
  final int indexOfBigGrid;
  final int indexOfSmallGrid;

  TappedOnGridEvent({required this.indexOfBigGrid, required this.indexOfSmallGrid});

  @override
  List<Object?> get props => [indexOfBigGrid, indexOfSmallGrid];
}

class RestartGameGridEvent extends GridEvent {
  @override
  List<Object?> get props => [];
}

class ResetToMenuGridEvent extends GridEvent {
  @override
  List<Object?> get props => [];
}


class SaveGameGridEvent extends GridEvent {
  @override
  List<Object?> get props => [];
}
