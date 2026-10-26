import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tic_tac_toe/domain/constants/test_elements.dart';
import 'package:tic_tac_toe/presentation/manager/statics_provider/statics_provider.dart';
import 'package:tic_tac_toe/utils/errors/app_debug_print.dart';

import '../../../domain/constants/enums.dart';
import '../../../domain/entities/game_state_entity.dart';
import '../../../domain/entities/grid_items_entity.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/handlers/check_grid_winner_handler.dart';
import '../../../domain/repositories/main_repository.dart';
import '../../../service_locator.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CheckGridWinnerHandler _checkGridWinner = CheckGridWinnerHandler();
  final MainRepository mainRepository;

  MainBloc({required this.mainRepository})
    : super(
        MainInitialState(
          players: testForMainInitialState.players,
          gameMode: testForMainInitialState.gameMode,
          selectedSize: testForMainInitialState.selectedSize,
          saveGame: testForMainInitialState.saveGame,
        ),
      ) {
    on<LoadMainEvent>(_onLoadMainEvent);
    on<ChangeMainInitialElementsMainEvent>(_onChangeMainInitialElementsMainEvent);
    on<AddPlayerToMainEvent>(_onAddPlayerToMainEvent);
    on<CreatePlayerMainEvent>(_onCreatePlayerMainEvent);
    on<ClearPlayerMainEvent>(_onClearPlayerMainEvent);
    on<StartGameMainEvent>(_onStartGameMainEvent);
    on<TappedOnMainEvent>(_onTappedOnMainEvent);
    on<RestartGameMainEvent>(_onRestartGameMainEvent);
    on<ExitGameMainEvent>(_onExitGameMainEvent);
    on<FinishAndRestartGameMainEvent>(_onFinishAndRestartGameMainEvent);
    on<FinishAndExitGameMainEvent>(_onFinishAndExitGameMainEvent);
    // on<SaveGameMainEvent>(_onSaveGameMainEvent);
  }

  /// Before MainInitialState:
  // Задача _onLoadMainEvent — получить список игроков из БД
  // перед запуском приложения
  FutureOr<void> _onLoadMainEvent(
    LoadMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    final currentState = state as MainInitialState;
    final playerList = await mainRepository.getPlayersByRanking();
    sl<StaticsProvider>().getAllPlayers(playerList);
    emit(currentState.copyWith(players: playerList));
  }

  /// In MainInitialState:
  // Задача _onChangeMainInitialElementsMainEvent — изменить состояние
  // игры в зависимости от выбранных параметров игры
  FutureOr<void> _onChangeMainInitialElementsMainEvent(
    ChangeMainInitialElementsMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    final currentState = state as MainInitialState;
    final object = event.object;
    if (object is GameMode) {
      emit(currentState.copyWith(gameMode: object));
      appDebugPrint(
        e: currentState.toString(),
        stackTrace: StackTrace.fromString(''),
        from: '_onChangeMainInitialElementsMainEvent',
      );
    } else if (object is int) {
      emit(currentState.copyWith(selectedSize: object));
      appDebugPrint(
        e: currentState.toString(),
        stackTrace: StackTrace.fromString(''),
        from: '_onChangeMainInitialElementsMainEvent',
      );
    } else if (object is SaveGame) {
      emit(currentState.copyWith(saveGame: object));
      appDebugPrint(
        e: currentState.toString(),
        stackTrace: StackTrace.fromString(''),
        from: '_onChangeMainInitialElementsMainEvent',
      );
    } else {
      return;
    }
  }

  // Задача _onAddPlayerToMainEvent — добавить игрока в игру
  FutureOr<void> _onAddPlayerToMainEvent(
    AddPlayerToMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    final currentState = state as MainInitialState;
    event.playerSymbol == PlayerSymbol.x
        ? emit(currentState.copyWith(selectedPlayerX: event.player))
        : emit(currentState.copyWith(selectedPlayerO: event.player));
    appDebugPrint(
      e: currentState.toString(),
      stackTrace: StackTrace.fromString(''),
      from: '_onAddPlayerToMainEvent',
    );
  }

  // Задача _onCreatePlayerMainEvent — создать игрока в БД
  FutureOr<void> _onCreatePlayerMainEvent(
    CreatePlayerMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    appDebugPrint(
      e: 'Create Player',
      stackTrace: StackTrace.fromString(''),
      from: 'Main Bloc',
    );
    final currentState = state as MainInitialState;
    // Сохраняем игрока в БД.
    await mainRepository.createPlayer(event.name);
    // Перезагружаем обновлённый список из БД.
    final updatedPlayers = await mainRepository.getPlayersByRanking();
    emit(currentState.copyWith(players: updatedPlayers));
    sl<StaticsProvider>().getAllPlayers(updatedPlayers);
  }

  // Задача _onClearPlayerMainEvent — очистить выбранного игрока
  FutureOr<void> _onClearPlayerMainEvent(
    ClearPlayerMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainInitialState) return;
    final currentState = state as MainInitialState;
    event.playerSymbol == PlayerSymbol.x
        ? emit(currentState.copyWith(clearPlayerX: true))
        : emit(currentState.copyWith(clearPlayerO: true));
  }

  // Задача _onStartGameMainEvent — собрать данные и начать игру
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
        gameState: startGameState,
        playerX:
            event.playerX ??
            PlayerEntity(
              id: 0,
              name: 'Player X',
              games: 0,
              wins: 0,
              losses: 0,
              draws: 0,
            ),
        playerO:
            event.playerO ??
            PlayerEntity(
              id: 0,
              name: 'Player O',
              games: 0,
              wins: 0,
              losses: 0,
              draws: 0,
            ),
        // gameSession: gameSession,
      ),
    );
  }

  /// In MainPlayingState:
  // Задача _onTappedOnMainEvent — сделать ход в игре
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

    if (currentBigCell.isNotEmpty || currentSmallCell.isNotEmpty) return;

    // Создаём копии игрового поля.
    final newSmallGridItems = gridItems.smallGridItems
        .map((innerList) => List<String>.from(innerList))
        .toList();

    final newBigGridItems = List<String>.from(gridItems.bigGridItems);

    final newPermissibleBigGrid = List<Permission>.from(
      gameState.permissibleBigGrid,
    );

    // Размещаем символ текущего игрока.
    final symbol = gameState.currentSymbol.name;
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
      currentSymbol: gameState.currentSymbol == PlayerSymbol.x
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
          gameState: currentState.gameState,
          gameGridItems: updatedGridItems,
          winnerPlayer: bigWinner == PlayerSymbol.x.name
              ? currentState.playerX
              : currentState.playerO,
          playerX: currentState.playerX,
          playerO: currentState.playerO,
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

  // Задача _onRestartGameMainEvent — начать игру заново с предыдущими данными.
  // Он не сохраняет значение в ДБ
  FutureOr<void> _onRestartGameMainEvent(
    RestartGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    // 1. Получаем текущие данные вне зависимости от того, Playing это или Finished
    final GridItemsEntity gridItems;
    final List<PlayerEntity> playersInGame;
    final GameStateEntity gameState;
    if (state is MainPlayingState) {
      final current = state as MainPlayingState;
      gridItems = current.gridItems;
      playersInGame = [current.playerX, current.playerO];
      gameState = current.gameState;
    } else if (state is MainFinishedState) {
      final current = state as MainFinishedState;
      gridItems = current.gameGridItems;
      playersInGame = [current.playerX, current.playerO];
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
      currentSymbol: PlayerSymbol.x,
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
        gameState: updatedGameState,
        playerX: playersInGame[0],
        playerO: playersInGame[1],
      ),
    );
  }

  // Задача _onResetToMenuMainEvent — вернуть в начальное окно с предыдущими
  // данными. Он не сохраняет значение в ДБ
  FutureOr<void> _onExitGameMainEvent(
    ExitGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainPlayingState) return;
    final currentState = state as MainPlayingState;

    /// MainInitialState должен брать данные (кроме playerX и playerO)
    /// из GameSettingsBloc, который еще не реализовал
    emit(
      MainInitialState(
        players: testForMainInitialState.players,
        selectedPlayerX: currentState.playerX,
        selectedPlayerO: currentState.playerO,
        gameMode: currentState.gameState.gameMode,
        selectedSize: testForMainInitialState.selectedSize,
        saveGame: currentState.gameState.saveGame,
      ),
    );
  }

  FutureOr<void> _onFinishAndRestartGameMainEvent(
    FinishAndRestartGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainFinishedState) return;
    final currentState = state as MainFinishedState;
    if (currentState.gameState.saveGame == SaveGame.yes) {
      await mainRepository.recordFinishedGame(
        playerXId: currentState.playerX.id,
        playerOId: currentState.playerO.id,
        winnerPlayerId: currentState.winnerPlayer.id,
        mode: currentState.gameState.gameMode,
      );
    }
    emit(
      MainPlayingState(
        gridItems: currentState.gameGridItems,
        gameState: currentState.gameState,
        playerX: currentState.playerX,
        playerO: currentState.playerO,
      ),
    );
  }

  FutureOr<void> _onFinishAndExitGameMainEvent(
    FinishAndExitGameMainEvent event,
    Emitter<MainState> emit,
  ) async {
    if (state is! MainFinishedState) return;
    final currentState = state as MainFinishedState;
    if (currentState.gameState.saveGame == SaveGame.yes) {
      await mainRepository.recordFinishedGame(
        playerXId: currentState.playerX.id,
        playerOId: currentState.playerO.id,
        winnerPlayerId: currentState.winnerPlayer.id,
        mode: currentState.gameState.gameMode,
      );
    }
    emit(
      MainInitialState(
        players: testForMainInitialState.players,
        selectedPlayerX: currentState.playerX,
        selectedPlayerO: currentState.playerO,
        gameMode: currentState.gameState.gameMode,
        selectedSize: testForMainInitialState.selectedSize,
        saveGame: currentState.gameState.saveGame,
      ),
    );
  }
}
