import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../domain/entities/grid_items_entity.dart';
import '../../../domain/entities/game_state_entity.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/handlers/check_grid_winner_handler.dart';
import '../../../domain/repositories/main_repository.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends HydratedBloc<MainEvent, MainState> {
  final CheckGridWinnerHandler _checkGridWinner = CheckGridWinnerHandler();
  final MainRepository mainRepository;

  MainBloc({required this.mainRepository})
    : super(
        MainInitialState(
          players: [
            PlayerEntity(
              id: 0,
              name: 'Player 1',
              games: 0,
              wins: 0,
              losses: 0,
              draws: 0,
            ),
            PlayerEntity(
              id: 1,
              name: 'Player 2',
              games: 0,
              wins: 0,
              losses: 0,
              draws: 0,
            ),
          ],
          gameMode: GameMode.classic,
          selectedSize: 4,
          saveGame: SaveGame.no,
        ),
      ) {
    on<LoadMainEvent>(_onLoadMainEvent);
    on<StartGameMainEvent>(_onStartGameMainEvent);
    on<TappedOnMainEvent>(_onTappedOnMainEvent);
    on<RestartGameMainEvent>(_onRestartGameMainEvent);
    on<ResetToMenuMainEvent>(_onResetToMenuMainEvent);
    on<SaveGameMainEvent>(_onSaveGameMainEvent);
  }

  FutureOr<void> _onLoadMainEvent(
    LoadMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    final currentState = state as MainInitialState;
    final playerList = await mainRepository.getPlayersByRanking();
    emit(currentState.copyWith(players: playerList));
  }

  FutureOr<void> _onStartGameMainEvent(
    StartGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    final GridItemsEntity startGridItems;

    switch (event.gameMode) {
      case GameMode.classic:
        startGridItems = GridItemsEntity(
          bigGridItems: List.generate(1, (index) => ''),
          bigGridCrossAxisCount: 1,
          bigGridWinLength: 1,
          smallGridItems: List.generate(
            1,
            (index) => List.generate(9, (index) => ''),
          ),
          smallGridCrossAxisCount: 3,
          smallGridWinLength: 3,
        );
        break;

      case GameMode.ultimate:
        startGridItems = GridItemsEntity(
          bigGridItems: List.generate(9, (index) => ''),
          bigGridCrossAxisCount: 3,
          bigGridWinLength: 3,
          smallGridItems: List.generate(
            9,
            (index) => List.generate(9, (index) => ''),
          ),
          smallGridCrossAxisCount: 3,
          smallGridWinLength: 3,
        );
        break;

      case GameMode.expanded:
        final n = event.selectedSize;
        startGridItems = GridItemsEntity(
          bigGridItems: List.generate(1, (index) => ''),
          bigGridCrossAxisCount: 1,
          bigGridWinLength: 1,
          smallGridItems: List.generate(
            1,
            (index) => List.generate(n * n, (index) => ''),
          ),
          smallGridCrossAxisCount: n,
          smallGridWinLength: n,
        );
        break;

      case GameMode.threeInARow:
        final n = event.selectedSize;
        startGridItems = GridItemsEntity(
          bigGridItems: List.generate(1, (index) => ''),
          bigGridCrossAxisCount: 1,
          bigGridWinLength: 1,
          smallGridItems: List.generate(
            1,
            (index) => List.generate(n * n, (index) => ''),
          ),
          smallGridCrossAxisCount: n,
          smallGridWinLength: 3,
        );
        break;
    }

    // final gameSession = GameSessionEntity();

    final startGameState = GameStateEntity(
      gameMode: event.gameMode,
      permissibleBigGrid: List.generate(
        startGridItems.bigGridItems.length,
        (index) => Permission.permissible,
      ),
      saveGame: event.saveGame,
    );

    emit(
      MainPlayingState(
        gridItems: startGridItems,
        // gameSession: gameSession,
        gameState: startGameState,
      ),
    );
  }

  FutureOr<void> _onTappedOnMainEvent(
    TappedOnMainEvent event,
    Emitter<MainState> emit,
  ) async {
    // Проверяем, что игра активна.
    if (state is! MainPlayingState) return;

    final currentState = state as MainPlayingState;

    // Получаем текущие игровые данные.
    final gridItems = currentState.gridItems;
    final gameState = currentState.gameState;

    final sizeBigGrid = gridItems.bigGridCrossAxisCount;
    final sizeSmallGrid = gridItems.smallGridCrossAxisCount;
    final winBigLength = gridItems.bigGridWinLength;
    final winSmallLength = gridItems.smallGridWinLength;

    final indexBig = event.indexOfBigGrid;
    final indexSmall = event.indexOfSmallGrid;

    // Проверяем допустимость индексов.
    if (indexBig < 0 ||
        indexBig >= gridItems.bigGridItems.length ||
        indexSmall < 0 ||
        indexSmall >= gridItems.smallGridItems[indexBig].length) {
      return;
    }

    /// После первого хода игрок должен следовать индексу
    /// следующей большой сетки, если она ещё не завершена.
    if (gameState.permissibleBigGrid[indexBig] == Permission.notPermissible) return;

    // Проверяем, свободны ли выбранная большая и маленькая клетки.
    final currentBigCell = gridItems.bigGridItems[indexBig];
    final currentSmallCell = gridItems.smallGridItems[indexBig][indexSmall];

    if (currentBigCell.isNotEmpty || currentSmallCell.isNotEmpty) {
      return;
    }

    // Создаём копии игрового поля.
    final newSmallGridItems = gridItems.smallGridItems
        .map((innerList) => List<String>.from(innerList))
        .toList();

    final newBigGridItems = List<String>.from(gridItems.bigGridItems);

    final newPermissibleBigGrid = List<Permission>.from(
      gameState.permissibleBigGrid,
    );

    // Размещаем символ текущего игрока.
    final symbol = gameState.currentPlayer.name;
    newSmallGridItems[indexBig][indexSmall] = symbol;

    // Проверяем победу в маленькой сетке.
    // final winLength = gameState.gameMode == GameMode.threeInARow ? 3 : sizeSmallGrid;
    final smallWinner = _checkGridWinner(
      grid: newSmallGridItems[indexBig],
      size: sizeSmallGrid,
      winLength: winSmallLength,
    );

    if (smallWinner == PlayerSymbol.x.name || smallWinner == PlayerSymbol.o.name) {
      newBigGridItems[indexBig] = smallWinner;
    } else if (newSmallGridItems[indexBig].every((cell) => cell.isNotEmpty)) {
      // Маленькая сетка заполнена, но победителя нет.
      newBigGridItems[indexBig] = 'draw';
    }

    // Очищаем первичные разрешения
    for (int i = 0; i < newPermissibleBigGrid.length; i++) {
      newPermissibleBigGrid[i] = Permission.notPermissible;
    }

    /// Если целевая большая сетка уже завершена,
    /// следующий игрок сможет выбрать другую доступную сетку.
    final nextBigGridIndex = sizeBigGrid == 1 ? 0 : indexSmall;
    if (newBigGridItems[nextBigGridIndex].isEmpty) {
      newPermissibleBigGrid[nextBigGridIndex] = Permission.permissible;
    } else {
      for (int i = 0; i < newPermissibleBigGrid.length; i++) {
        if (newBigGridItems[i].isEmpty) {
          newPermissibleBigGrid[i] = Permission.permissible;
        } else {
          newPermissibleBigGrid[i] = Permission.notPermissible;
        }
      }
    }

    // Формируем обновлённые игровые данные.
    final updatedGridItems = gridItems.copyWith(
      smallGridItems: newSmallGridItems,
      bigGridItems: newBigGridItems,
    );

    final updatedGameState = gameState.copyWith(
      currentPlayer: gameState.currentPlayer == PlayerSymbol.x
          ? PlayerSymbol.o
          : PlayerSymbol.x,
      moveCount: gameState.moveCount + 1,
      permissibleBigGrid: newPermissibleBigGrid,
    );

    // Проверяем победу в большой сетке.
    final bigWinner = _checkGridWinner(
      grid: newBigGridItems,
      size: sizeBigGrid,
      winLength: winBigLength,
    );

    if (bigWinner == PlayerSymbol.x.name || bigWinner == PlayerSymbol.o.name) {
      emit(
        MainFinishedState(
          // gameSession: currentState.gameSession,
          gameState: currentState.gameState,
          gameGridItems: updatedGridItems,
        ),
      );
      return;
    }

    // Публикуем обновлённое состояние игры.
    emit(
      currentState.copyWith(
        gridItems: updatedGridItems,
        gameState: updatedGameState,
      ),
    );
  }

  FutureOr<void> _onRestartGameMainEvent(
    RestartGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    // 1. Получаем текущие данные вне зависимости от того, Playing это или Finished
    final GridItemsEntity gridItems;
    // final GameSessionEntity session;
    final GameStateEntity gameState;
    if (state is MainPlayingState) {
      final current = state as MainPlayingState;
      gridItems = current.gridItems;
      // session = current.gameSession;
      gameState = current.gameState;
    } else if (state is MainFinishedState) {
      final current = state as MainFinishedState;
      gridItems = current.gameGridItems;
      // session = current.gameSession;
      gameState = current.gameState;
    } else {
      return;
    }
    // 2. Создаем чистое поле с сохранением исходных размеров сетки
    final cellsPerSmallGrid = gridItems.smallGridItems.isNotEmpty
        ? gridItems.smallGridItems[0].length
        : (gridItems.smallGridCrossAxisCount * gridItems.smallGridCrossAxisCount);
    final updatedGridItems = gridItems.copyWith(
      bigGridItems: List.generate(gridItems.bigGridItems.length, (_) => ''),
      smallGridItems: List.generate(
        gridItems.bigGridItems.length,
        (_) => List.generate(cellsPerSmallGrid, (_) => ''),
      ),
    );
    final updatedGameState = gameState.copyWith(
      currentPlayer: PlayerSymbol.x,
      moveCount: 0,
      permissibleBigGrid: List.generate(
        gridItems.bigGridItems.length,
        (_) => Permission.permissible,
      ),
    );
    // 3. Эмитим GridPlayingState для начала новой партии
    emit(
      MainPlayingState(
        gridItems: updatedGridItems,
        // gameSession: session,
        gameState: updatedGameState,
      ),
    );
  }

  FutureOr<void> _onResetToMenuMainEvent(
    ResetToMenuMainEvent event,
    Emitter<MainState> emit,
  ) async {
    /// При MainFinishedState сохраняем игру в БД,
    /// При Игре нет!!!!
    // if (state is! MainFinishedState) return;
    // if (event.saveGame == SaveGame.yes) {
    //   await mainRepository.recordFinishedGame(
    //     playerAId: event.playerAId,
    //     playerBId: event.playerBId,
    //     winnerPlayerId: event.winnerPlayerId,
    //     mode: event.mode,
    //   );
    // }
    emit(
      MainInitialState(
        players: [
          PlayerEntity(
            id: 0,
            name: 'Player 1',
            games: 0,
            wins: 0,
            losses: 0,
            draws: 0,
          ),
          PlayerEntity(
            id: 1,
            name: 'Player 2',
            games: 0,
            wins: 0,
            losses: 0,
            draws: 0,
          ),
        ],
        gameMode: GameMode.classic,
        selectedSize: 4,
        saveGame: SaveGame.no,
      ),
    );
  }

  FutureOr<void> _onSaveGameMainEvent(
    SaveGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainFinishedState) return;
    await mainRepository.recordFinishedGame(
      playerAId: event.playerAId,
      playerBId: event.playerBId,
      winnerPlayerId: event.winnerPlayerId,
      mode: event.mode,
    );
    emit(
      MainInitialState(
        players: [],
        gameMode: GameMode.classic,
        selectedSize: 4,
        saveGame: SaveGame.no,
      ),
    );
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    if (json['gridItems'] != null) {
      return MainPlayingState(
        gridItems: GridItemsEntity.fromJson(json['gridItems']),
        // gameSession: GameSessionEntity.fromJson(json['gameSession']),
        gameState: GameStateEntity.fromJson(json['gameState']),
      );
    } else {
      return MainFinishedState(
        gameGridItems: GridItemsEntity.fromJson(json['gameGridItems']),
        // gameSession: GameSessionEntity.fromJson(json['gameSession']),
        gameState: GameStateEntity.fromJson(json['gameState']),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(MainState state) {
    if (state is MainPlayingState) {
      return {
        'gridItems': state.gridItems.toJson(),
        // 'gameSession': state.gameSession.toJson(),
        'gameState': state.gameState.toJson(),
      };
    }
    if (state is MainFinishedState) {
      return {
        'gameGridItems': state.gameGridItems.toJson(),
        // 'gameSession': state.gameSession.toJson(),
        'gameState': state.gameState.toJson(),
      };
    }
    return null;
  }
}
