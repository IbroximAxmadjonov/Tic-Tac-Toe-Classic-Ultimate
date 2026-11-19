import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/main_repository.dart';
import '../statics_provider/statics_provider.dart';

part 'players_event.dart';

part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final MainRepository _mainRepository;
  final StaticsProvider _staticsProvider;

  PlayersBloc({required this._mainRepository, required this._staticsProvider})
    : super(PlayersState(playersList: [])) {
    on<RenamePlayerEvent>(_onRenamePlayerEvent);
    on<DeletePlayerEvent>(_onDeletePlayerEvent);
    on<GetPlayerEvent>(_onGetPlayerEvent);
    on<LoadPlayerPairsEvent>(_onLoadPlayerPairsEvent);
    on<LoadSessionsForPairEvent>(_onLoadSessionsForPairEvent);
  }

  FutureOr<void> _onRenamePlayerEvent(
    RenamePlayerEvent event,
    Emitter<PlayersState> emit,
  ) async {
    await _mainRepository.renamePlayer(
      playerId: event.playerId,
      newName: event.newName,
    );
    final updatedPlayers = await _mainRepository.getPlayersByRanking();
    _staticsProvider.getAllPlayers(updatedPlayers);
    // if (state is HomeSetupState) {
    //   final currentState = state as HomeSetupState;
    //   final updatedPlayerX = currentState.selectedPlayerX?.id == event.playerId
    //       ? currentState.selectedPlayerX?.copyWith(name: event.newName.trim())
    //       : currentState.selectedPlayerX;
    //   final updatedPlayerO = currentState.selectedPlayerO?.id == event.playerId
    //       ? currentState.selectedPlayerO?.copyWith(name: event.newName.trim())
    //       : currentState.selectedPlayerO;
    //   emit(
    //     currentState.copyWith(
    //       players: updatedPlayers,
    //       selectedPlayerX: updatedPlayerX,
    //       selectedPlayerO: updatedPlayerO,
    //     ),
    //   );
    // }
  }

  FutureOr<void> _onDeletePlayerEvent(
    DeletePlayerEvent event,
    Emitter<PlayersState> emit,
  ) async {
    await _mainRepository.deletePlayer(event.playerId);
    final updatedPlayers = await _mainRepository.getPlayersByRanking();
    final updatedPairs = await _mainRepository.getPlayerPairs();
    _staticsProvider.getAllPlayers(updatedPlayers);
    // if (state is HomeSetupState) {
    //   final currentState = state as HomeSetupState;
    //   emit(
    //     currentState.copyWith(
    //       players: updatedPlayers,
    //       playerPairs: updatedPairs,
    //       clearPlayerX: currentState.selectedPlayerX?.id == event.playerId,
    //       clearPlayerO: currentState.selectedPlayerO?.id == event.playerId,
    //     ),
    //   );
    // }
  }

  FutureOr<void> _onGetPlayerEvent(
    GetPlayerEvent event,
    Emitter<PlayersState> emit,
  ) async {
    await _mainRepository.getPlayer(event.playerId);
    // Пока не знаю где использвать возмоножно уберу _onGetPlayerMainEvent
  }

  FutureOr<void> _onLoadPlayerPairsEvent(
    LoadPlayerPairsEvent event,
    Emitter<PlayersState> emit,
  ) async {
    final pairs = await _mainRepository.getPlayerPairs();
    // if (state is HomeSetupState) {
    //   final currentState = state as HomeSetupState;
    //   emit(currentState.copyWith(playerPairs: pairs));
    // }
  }

  FutureOr<void> _onLoadSessionsForPairEvent(
    LoadSessionsForPairEvent event,
    Emitter<PlayersState> emit,
  ) async {
    final sessions = await _mainRepository.getSessionsForPair(event.pairId);
    // if (state is HomeSetupState) {
    //   final currentState = state as HomeSetupState;
    //   emit(currentState.copyWith(selectedPairSessions: sessions));
    // }
  }
}
