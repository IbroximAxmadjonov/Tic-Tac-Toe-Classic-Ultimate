part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class LoadHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

/// Меняем настройки игры
class ChangeGameModeHomeEvent extends HomeEvent {
  final GameMode gameMode;

  ChangeGameModeHomeEvent({required this.gameMode});

  @override
  List<Object?> get props => [gameMode];
}

class ChangeSelectedSizeHomeEvent extends HomeEvent {
  final int selectedSize;

  ChangeSelectedSizeHomeEvent({required this.selectedSize});

  @override
  List<Object?> get props => [selectedSize];
}

class ChangeSaveGameHomeEvent extends HomeEvent {
  final SaveGame saveGame;

  ChangeSaveGameHomeEvent({required this.saveGame});

  @override
  List<Object?> get props => [saveGame];
}

/// Добавляет игрока в слот 1 (playerSymbol == PlayerSymbol.x) или 2 (playerSymbol == PlayerSymbol.o).
class AddPlayerToHomeEvent extends HomeEvent {
  final PlayerSymbol playerSymbol;
  final PlayerEntity player;

  AddPlayerToHomeEvent({required this.playerSymbol, required this.player});

  @override
  List<Object?> get props => [playerSymbol, player];
}

/// Создаёт нового игрока в БД и обновляет список игроков в состоянии.
class CreatePlayerHomeEvent extends HomeEvent {
  final String name;

  CreatePlayerHomeEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

/// Очищает выбранного игрока в слоте 1 (playerSymbol == PlayerSymbol.x) или 2 (playerSymbol == PlayerSymbol.o).
class ClearPlayerHomeEvent extends HomeEvent {
  final PlayerSymbol playerSymbol;

  ClearPlayerHomeEvent({required this.playerSymbol});

  @override
  List<Object?> get props => [playerSymbol];
}

/// Начинает игру.
class StartGameHomeEvent extends HomeEvent {
  final GameMode gameMode;
  final int selectedSize;
  final SaveGame saveGame;
  final PlayerEntity? playerX;
  final PlayerEntity? playerO;

  StartGameHomeEvent({
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
class TappedOnHomeEvent extends HomeEvent {
  final int indexOfBigGrid;
  final int indexOfSmallGrid;

  TappedOnHomeEvent({required this.indexOfBigGrid, required this.indexOfSmallGrid});

  @override
  List<Object?> get props => [indexOfBigGrid, indexOfSmallGrid];
}

class RestartGameHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ExitGameHomeEvent extends HomeEvent {
  ExitGameHomeEvent();

  @override
  List<Object?> get props => [];
}

/// In MainFinishedState:

class FinishAndRestartGameHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FinishAndExitGameHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
