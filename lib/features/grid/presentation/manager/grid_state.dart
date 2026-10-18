part of 'grid_block.dart';

abstract class GridState extends Equatable {}

class GridInitialState extends GridState {
  @override
  List<Object?> get props => [];
}

class GridPlayingState extends GridState {
  final GameGridItemsEntity gameGridItems;
  final GameSessionEntity gameSession;
  final GameStateEntity gameState;

  GridPlayingState({
    required this.gameGridItems,
    required this.gameSession,
    required this.gameState,
  });

  GridPlayingState copyWith({
    GameGridItemsEntity? gameGridItems,
    GameSessionEntity? gameSession,
    GameStateEntity? gameState,
  }) {
    return GridPlayingState(
      gameGridItems: gameGridItems ?? this.gameGridItems,
      gameSession: gameSession ?? this.gameSession,
      gameState: gameState ?? this.gameState,
    );
  }

  @override
  List<Object?> get props => [gameGridItems, gameSession, gameState];
}

class GridFinishedState extends GridState {
  final GameSessionEntity gameSession;
  final GameStateEntity gameState;
  final GameGridItemsEntity gameGridItems;

  GridFinishedState({required this.gameSession, required this.gameState, required this.gameGridItems});

  @override
  List<Object?> get props => [gameSession, gameState, gameGridItems];
}

/// =============================

class GridBeforeTheGameStartsState extends GridState {
  GridBeforeTheGameStartsState();

  @override
  List<Object?> get props => [];
}
//
// class GridErrorState extends GridState {
//   final String message;
//
//   GridErrorState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridSuccessState extends GridState {
//   final String message;
//
//   GridSuccessState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridUpdateState extends GridState {
//   final String message;
//
//   GridUpdateState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridResetState extends GridState {
//   final String message;
//
//   GridResetState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridExitState extends GridState {
//   final String message;
//
//   GridExitState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridRestartState extends GridState {
//   final String message;
//
//   GridRestartState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridSaveState extends GridState {
//   final String message;
//
//   GridSaveState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridLoadState extends GridState {
//   final String message;
//
//   GridLoadState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class GridDeleteState extends GridState {
//   final String message;
//
//   GridDeleteState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
