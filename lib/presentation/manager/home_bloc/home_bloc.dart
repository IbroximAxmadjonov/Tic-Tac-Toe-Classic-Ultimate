import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/enums.dart';
import '../../../domain/constants/test_elements.dart';
import '../../../domain/entities/game_state_entity.dart';
import '../../../domain/entities/grid_items_entity.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/handlers/check_grid_winner_handler.dart';
import '../../../domain/repositories/main_repository.dart';
import '../../../utils/errors/app_debug_print.dart';
import '../setting_bloc/setting_bloc.dart';
import '../statics_provider/statics_provider.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const CheckGridWinnerHandler _checkGridWinner = CheckGridWinnerHandler();
  final MainRepository _mainRepository;
  final SettingBloc _settingBloc;
  final StaticsProvider _staticsProvider;
  late final StreamSubscription<SettingState> _settingSubscription;

  HomeBloc({
    required this._mainRepository,
    required this._settingBloc,
    required this._staticsProvider,
  }) : super(HomeInitialState()) {
    on<LoadHomeEvent>(_onLoadHomeEvent);
    on<ChangeGameModeHomeEvent>(_onChangeGameModeHomeEvent);
    on<ChangeSelectedSizeHomeEvent>(_onChangeSelectedSizeHomeEvent);
    on<ChangeSaveGameHomeEvent>(_onChangeSaveGameHomeEvent);
    on<AddPlayerToHomeEvent>(_onAddPlayerToHomeEvent);
    on<CreatePlayerHomeEvent>(_onCreatePlayerHomeEvent);
    on<ClearPlayerHomeEvent>(_onClearPlayerHomeEvent);
    on<StartGameHomeEvent>(_onStartGameHomeEvent);
    on<TappedOnHomeEvent>(_onTappedOnHomeEvent);
    on<RestartGameHomeEvent>(_onRestartGameHomeEvent);
    on<ExitGameHomeEvent>(_onExitGameHomeEvent);
    on<FinishAndRestartGameHomeEvent>(_onFinishAndRestartGameHomeEvent);
    on<FinishAndExitGameHomeEvent>(_onFinishAndExitGameHomeEvent);
    _settingSubscription = _settingBloc.stream.listen((state) {
      add(ChangeGameModeHomeEvent(gameMode: state.gameMode));
      add(ChangeSelectedSizeHomeEvent(selectedSize: state.selectedSize));
      add(ChangeSaveGameHomeEvent(saveGame: state.saveGame));
    });
  }

  /// Before HomeSetupState:
  // Задача _onLoadMainEvent — получить список игроков и пар из БД
  FutureOr<void> _onLoadHomeEvent(
    LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeInitialState) return;
    final playerList = await _mainRepository.getPlayersByRanking();
    _staticsProvider.getAllPlayers(playerList);
    emit(
      HomeSetupState(
        playersList: playerList,
        gameMode: _settingBloc.state.gameMode,
        selectedSize: _settingBloc.state.selectedSize,
      ),
    );
  }

  /// In HomeSetupState:
  // Задача _onChangeGameModeMainEvent — изменить режим игры
  FutureOr<void> _onChangeGameModeHomeEvent(
    ChangeGameModeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    final currentState = state as HomeSetupState;
    emit(currentState.copyWith(gameMode: event.gameMode));
    appDebugPrint(
      e: currentState.toString(),
      stackTrace: StackTrace.fromString(''),
      from: '_onChangeGameModeMainEvent',
    );
  }

  // Задача _onChangeGridSizeMainEvent — изменить размер сетки
  FutureOr<void> _onChangeSelectedSizeHomeEvent(
    ChangeSelectedSizeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    final currentState = state as HomeSetupState;
    emit(currentState.copyWith(selectedSize: event.selectedSize));
    appDebugPrint(
      e: currentState.toString(),
      stackTrace: StackTrace.fromString(''),
      from: '_onChangeGridSizeMainEvent',
    );
  }

  // Задача _onChangeSaveGameMainEvent — изменить сохранение игры
  FutureOr<void> _onChangeSaveGameHomeEvent(
    ChangeSaveGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    final currentState = state as HomeSetupState;
    emit(currentState.copyWith(saveGame: event.saveGame));
    appDebugPrint(
      e: currentState.toString(),
      stackTrace: StackTrace.fromString(''),
      from: '_onChangeSaveGameMainEvent',
    );
  }

  // Задача _onAddPlayerToMainEvent — добавить игрока в игру
  FutureOr<void> _onAddPlayerToHomeEvent(
    AddPlayerToHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    final currentState = state as HomeSetupState;
    if (event.playerSymbol == PlayerSymbol.x) {
      emit(currentState.copyWith(selectedPlayerX: event.player));
    } else {
      emit(currentState.copyWith(selectedPlayerO: event.player));
    }
    appDebugPrint(
      e: currentState.toString(),
      stackTrace: StackTrace.fromString(''),
      from: '_onAddPlayerToMainEvent',
    );
  }

  // Задача _onCreatePlayerMainEvent — создать игрока в БД
  FutureOr<void> _onCreatePlayerHomeEvent(
    CreatePlayerHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    appDebugPrint(
      e: 'Create Player: ${event.name}',
      stackTrace: StackTrace.fromString(''),
      from: 'Main Bloc',
    );
    final currentState = state as HomeSetupState;
    // Сохраняем игрока в БД.
    await _mainRepository.createPlayer(event.name);
    // Перезагружаем обновлённый список из БД.
    final updatedPlayers = await _mainRepository.getPlayersByRanking();
    emit(currentState.copyWith(playersList: updatedPlayers));
    _staticsProvider.getAllPlayers(updatedPlayers);
  }

  // Задача _onClearPlayerMainEvent — очистить выбранного игрока
  FutureOr<void> _onClearPlayerHomeEvent(
    ClearPlayerHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSetupState) return;
    final currentState = state as HomeSetupState;
    if (event.playerSymbol == PlayerSymbol.x) {
      emit(currentState.copyWith(clearPlayerX: true));
    } else {
      emit(currentState.copyWith(clearPlayerO: true));
    }
  }

  // Задача _onStartGameMainEvent — собрать данные и начать игру
  FutureOr<void> _onStartGameHomeEvent(
    StartGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    final startGridItems = GridItemsEntity.byMode(
      mode: event.gameMode,
      size: event.selectedSize,
    );
    final startGameState = GameStateEntity(
      gameMode: event.gameMode,
      permissibleBigGrid: List.filled(
        startGridItems.bigGridItems.length,
        Permission.permissible,
      ),
      saveGame: event.saveGame,
    );

    emit(
      HomePlayingState(
        gridItems: startGridItems,
        gameState: startGameState,
        playerX: event.playerX ?? PlayerEntity.mockPlayerX(),
        playerO: event.playerO ?? PlayerEntity.mockPlayerO(),
      ),
    );
  }

  /// In HomePlayingState:
  // Задача _onTappedOnMainEvent — сделать ход в игре
  FutureOr<void> _onTappedOnHomeEvent(
    TappedOnHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Проверяем, что игра активна.
    if (state is! HomePlayingState) return;

    final currentState = state as HomePlayingState;

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
    if (gameState.permissibleBigGrid[indexBig] == Permission.notPermissible) {
      return;
    }

    // Проверяем, свободны ли выбранная большая и маленькая клетки.
    final currentBigCell = gridItems.bigGridItems[indexBig];
    final currentSmallCell = gridItems.smallGridItems[indexBig][indexSmall];

    if (currentBigCell.isNotEmpty || currentSmallCell.isNotEmpty) return;

    // Создаём копии игрового поля.
    final newSmallGridItems = gridItems.smallGridItems
        .map((innerList) => List<String>.from(innerList))
        .toList();

    final newBigGridItems = List<String>.from(gridItems.bigGridItems);

    final newPermissibleBigGrid = List<Permission>.filled(
      gridItems.bigGridItems.length,
      Permission.notPermissible,
    );

    // Размещаем символ текущего игрока.
    final symbol = gameState.currentSymbol.name;
    newSmallGridItems[indexBig][indexSmall] = symbol;

    // Проверяем победу в маленькой сетке.
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

    if (bigWinner == PlayerSymbol.x.name) {
      emit(
        HomeFinishedState(
          gameState: updatedGameState,
          gameGridItems: updatedGridItems,
          winnerPlayer: currentState.playerX,
          playerX: currentState.playerX,
          playerO: currentState.playerO,
        ),
      );
      return;
    } else if (bigWinner == PlayerSymbol.o.name) {
      emit(
        HomeFinishedState(
          gameState: updatedGameState,
          gameGridItems: updatedGridItems,
          winnerPlayer: currentState.playerO,
          playerX: currentState.playerX,
          playerO: currentState.playerO,
        ),
      );
      return;
    } else if (newBigGridItems.every((cell) => cell.isNotEmpty)) {
      // Ничья на всем поле
      emit(
        HomeFinishedState(
          gameState: updatedGameState,
          gameGridItems: updatedGridItems,
          winnerPlayer: null,
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
  FutureOr<void> _onRestartGameHomeEvent(
    RestartGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    final GridItemsEntity gridItems;
    final List<PlayerEntity> playersInGame;
    final GameStateEntity gameState;
    if (state is HomePlayingState) {
      final current = state as HomePlayingState;
      gridItems = current.gridItems;
      playersInGame = [current.playerX, current.playerO];
      gameState = current.gameState;
    } else if (state is HomeFinishedState) {
      final current = state as HomeFinishedState;
      gridItems = current.gameGridItems;
      playersInGame = [current.playerX, current.playerO];
      gameState = current.gameState;
    } else {
      return;
    }
    final updatedGridItems = GridItemsEntity.byMode(
      mode: gameState.gameMode,
      size: gridItems.smallGridCrossAxisCount,
    );
    final updatedGameState = gameState.copyWith(
      currentSymbol: PlayerSymbol.x,
      moveCount: 0,
      permissibleBigGrid: List.filled(
        gridItems.bigGridItems.length,
        Permission.permissible,
      ),
    );

    emit(
      HomePlayingState(
        gridItems: updatedGridItems,
        gameState: updatedGameState,
        playerX: playersInGame[0],
        playerO: playersInGame[1],
      ),
    );
  }

  // Задача _onExitGameMainEvent — вернуть в начальное окно с предыдущими данными
  FutureOr<void> _onExitGameHomeEvent(
    ExitGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomePlayingState) return;
    final currentState = state as HomePlayingState;
    final players = await _mainRepository.getPlayersByRanking();
    _staticsProvider.getAllPlayers(players);
    emit(
      HomeSetupState(
        playersList: players,
        selectedPlayerX: currentState.playerX,
        selectedPlayerO: currentState.playerO,
        gameMode: currentState.gameState.gameMode,
        selectedSize: testForHomeSetupState.selectedSize,
        saveGame: currentState.gameState.saveGame,
      ),
    );
  }

  FutureOr<void> _onFinishAndRestartGameHomeEvent(
    FinishAndRestartGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeFinishedState) return;
    final currentState = state as HomeFinishedState;
    if (currentState.gameState.saveGame == SaveGame.yes) {
      await _mainRepository.recordFinishedGame(
        playerXId: currentState.playerX.id,
        playerOId: currentState.playerO.id,
        winnerPlayerId: currentState.winnerPlayer?.id,
        mode: currentState.gameState.gameMode,
      );
      final updatedPlayers = await _mainRepository.getPlayersByRanking();
      _staticsProvider.getAllPlayers(updatedPlayers);
    }

    final gridItems = currentState.gameGridItems;
    final gameState = currentState.gameState;
    final updatedGridItems = GridItemsEntity.byMode(
      mode: gameState.gameMode,
      size: gridItems.smallGridCrossAxisCount,
    );
    final updatedGameState = gameState.copyWith(
      currentSymbol: PlayerSymbol.x,
      moveCount: 0,
      permissibleBigGrid: List.filled(
        gridItems.bigGridItems.length,
        Permission.permissible,
      ),
    );

    emit(
      HomePlayingState(
        gridItems: updatedGridItems,
        gameState: updatedGameState,
        playerX: currentState.playerX,
        playerO: currentState.playerO,
      ),
    );
  }

  FutureOr<void> _onFinishAndExitGameHomeEvent(
    FinishAndExitGameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeFinishedState) return;
    final currentState = state as HomeFinishedState;
    if (currentState.gameState.saveGame == SaveGame.yes) {
      await _mainRepository.recordFinishedGame(
        playerXId: currentState.playerX.id,
        playerOId: currentState.playerO.id,
        winnerPlayerId: currentState.winnerPlayer?.id,
        mode: currentState.gameState.gameMode,
      );
    }
    final updatedPlayers = await _mainRepository.getPlayersByRanking();
    _staticsProvider.getAllPlayers(updatedPlayers);

    emit(
      HomeSetupState(
        playersList: updatedPlayers,
        selectedPlayerX: currentState.playerX,
        selectedPlayerO: currentState.playerO,
        gameMode: currentState.gameState.gameMode,
        selectedSize: testForHomeSetupState.selectedSize,
        saveGame: currentState.gameState.saveGame,
      ),
    );
  }

  @override
  Future<void> close() {
    _settingSubscription.cancel();
    return super.close();
  }
}
