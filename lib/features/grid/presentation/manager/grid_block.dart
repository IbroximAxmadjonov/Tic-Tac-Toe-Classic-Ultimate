import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/core/domain/entities/game_session_entity.dart';
import 'package:tic_tac_toe/features/grid/domain/entities/game_grid_items_entity.dart';
import 'package:tic_tac_toe/features/grid/presentation/handlers/check_grid_winner_handler.dart';

import '../../../../core/domain/constants/enums.dart';
import '../../../../core/domain/entities/player_entity.dart';
import '../../domain/entities/game_state_entity.dart';

part 'grid_event.dart';

part 'grid_state.dart';

class GridBlock extends Bloc<GridEvent, GridState> {
  final CheckGridWinnerHandler _checkGridWinner = CheckGridWinnerHandler();

  GridBlock() : super(GridBeforeTheGameStartsState()) {
    on<StartGameGridEvent>(_onStartGameGridEvent);
    on<TappedOnGridEvent>(_onTappedOnGridEvent);
    on<RestartGameGridEvent>(_onRestartGameGridEvent);
    on<ResetToMenuGridEvent>(_onResetToMenuGridEvent);
    on<SaveGameGridEvent>(_onSaveGameGridEvent);
  }

  FutureOr<void> _onStartGameGridEvent(
    StartGameGridEvent event,
    Emitter<GridState> emit,
  ) async {
    final List<String> bigGridItems;
    final int bigGridCrossAxisCount;
    final List<List<String>> smallGridItems;
    final int smallGridCrossAxisCount;

    switch (event.gameMode) {
      case GameMode.classic:
        bigGridItems = List.generate(1, (index) => '');
        bigGridCrossAxisCount = 1;
        smallGridItems = List.generate(
          bigGridItems.length,
          (index) => List.generate(9, (index) => ''),
        );
        smallGridCrossAxisCount = 3;
        break;

      case GameMode.ultimate:
        bigGridItems = List.generate(9, (index) => '');
        bigGridCrossAxisCount = 3;
        smallGridItems = List.generate(
          bigGridItems.length,
          (index) => List.generate(9, (index) => ''),
        );
        smallGridCrossAxisCount = 3;
        break;

      case GameMode.expanded:
        final n = event.selectedSize;
        bigGridItems = List.generate(1, (index) => '');
        bigGridCrossAxisCount = 1;
        smallGridItems = List.generate(
          bigGridItems.length,
          (index) => List.generate(n * n, (index) => ''),
        );
        smallGridCrossAxisCount = n;
        break;

      case GameMode.threeInARow:
        final n = event.selectedSize;
        bigGridItems = List.generate(1, (index) => '');
        bigGridCrossAxisCount = 1;
        smallGridItems = List.generate(
          bigGridItems.length,
          (index) => List.generate(n * n, (index) => ''),
        );
        smallGridCrossAxisCount = n;
        break;
    }

    final gameGridItems = GameGridItemsEntity(
      bigGridItems: bigGridItems,
      bigGridCrossAxisCount: bigGridCrossAxisCount,
      smallGridItems: smallGridItems,
      smallGridCrossAxisCount: smallGridCrossAxisCount,
    );

    final gameSession = GameSessionEntity(
      sessionName: 'Session 0',
      xPlayer: PlayerEntity(
        name: 'Player 1',
        games: 0,
        wins: 0,
        losses: 0,
        draws: 0,
      ),
      oPlayer: PlayerEntity(
        name: 'Player 2',
        games: 0,
        wins: 0,
        losses: 0,
        draws: 0,
      ),
      lastGame: DateTime.now(),
    );

    final gameState = GameStateEntity(
      gameMode: event.gameMode,
      permissibleBigGrid: List.generate(
        bigGridItems.length,
        (index) => Permission.permissible,
      ),
    );

    emit(
      GridPlayingState(
        gameGridItems: gameGridItems,
        gameSession: gameSession,
        gameState: gameState,
      ),
    );
  }

  FutureOr<void> _onTappedOnGridEvent(
    TappedOnGridEvent event,
    Emitter<GridState> emit,
  ) async {
    // Проверяем, что игра активна.
    if (state is! GridPlayingState) return;

    final currentState = state as GridPlayingState;

    // Получаем текущие игровые данные.
    final gridItems = currentState.gameGridItems;
    final gameState = currentState.gameState;

    final sizeBigGrid = gridItems.bigGridCrossAxisCount;
    final sizeSmallGrid = gridItems.smallGridCrossAxisCount;

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
    if (gameState.firstMove
        ? false
        : gameState.permissibleBigGrid[indexBig] == Permission.notPermissible) {
      return;
    }

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
    final winLength = gameState.gameMode == GameMode.threeInARow ? 3 : sizeSmallGrid;
    final smallWinner = _checkGridWinner(
      grid: newSmallGridItems[indexBig],
      size: sizeSmallGrid,
      winLength: winLength,
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

    // Определяем целевую большую сетку следующего игрока.
    if (sizeBigGrid == 1) {
      newPermissibleBigGrid[0] = Permission.permissible;
    } else {
      newPermissibleBigGrid[indexSmall] = Permission.permissible;
    }
    final nextBigGridIndex = sizeBigGrid == 1 ? 0 : indexSmall;

    /// Если целевая большая сетка уже завершена,
    /// следующий игрок сможет выбрать другую доступную сетку.
    final nextBigGridIsOccupied = newBigGridItems[nextBigGridIndex].isNotEmpty;
    if (nextBigGridIsOccupied) {
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
      // nextBigGridIndex: nextBigGridIndex,
      permissibleBigGrid: newPermissibleBigGrid,
      firstMove: nextBigGridIsOccupied ? true : false,
    );

    // Проверяем победу в большой сетке.
    final bigWinner = _checkGridWinner(
      grid: newBigGridItems,
      size: sizeBigGrid,
      winLength: winLength,
    );

    if (bigWinner == PlayerSymbol.x.name || bigWinner == PlayerSymbol.o.name) {
      emit(
        GridFinishedState(
          gameSession: currentState.gameSession,
          gameState: currentState.gameState,
          gameGridItems: updatedGridItems,
        ),
      );
      return;
    }

    // Публикуем обновлённое состояние игры.
    emit(
      currentState.copyWith(
        gameGridItems: updatedGridItems,
        gameState: updatedGameState,
      ),
    );
  }

  FutureOr<void> _onRestartGameGridEvent(
    RestartGameGridEvent event,
    Emitter<GridState> emit,
  ) async {
    // 1. Получаем текущие данные вне зависимости от того, Playing это или Finished
    final GameGridItemsEntity gridItems;
    final GameSessionEntity session;
    final GameStateEntity gameState;
    if (state is GridPlayingState) {
      final current = state as GridPlayingState;
      gridItems = current.gameGridItems;
      session = current.gameSession;
      gameState = current.gameState;
    } else if (state is GridFinishedState) {
      final current = state as GridFinishedState;
      gridItems = current.gameGridItems;
      session = current.gameSession;
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
      firstMove: true,
    );
    // 3. Эмитим GridPlayingState для начала новой партии
    emit(
      GridPlayingState(
        gameGridItems: updatedGridItems,
        gameSession: session,
        gameState: updatedGameState,
      ),
    );
  }

  FutureOr<void> _onResetToMenuGridEvent(
    ResetToMenuGridEvent event,
    Emitter<GridState> emit,
  ) async {
    emit(GridBeforeTheGameStartsState());
  }

  FutureOr<void> _onSaveGameGridEvent(
    SaveGameGridEvent event,
    Emitter<GridState> emit,
  ) async {}
}
