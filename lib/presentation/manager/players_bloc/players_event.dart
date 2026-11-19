part of 'players_bloc.dart';

abstract class PlayersEvent extends Equatable {}

/// Переименовывает игрока в БД и обновляет список.
class RenamePlayerEvent extends PlayersEvent {
  final int playerId;
  final String newName;

  RenamePlayerEvent({required this.playerId, required this.newName});

  @override
  List<Object?> get props => [playerId, newName];
}

/// Удаляет игрока из БД и обновляет список.
class DeletePlayerEvent extends PlayersEvent {
  final int playerId;

  DeletePlayerEvent({required this.playerId});

  @override
  List<Object?> get props => [playerId];
}

/// Получает конкретного игрока по ID.
class GetPlayerEvent extends PlayersEvent {
  final int playerId;

  GetPlayerEvent({required this.playerId});

  @override
  List<Object?> get props => [playerId];
}

/// Загружает список пар игроков и их статистику.
class LoadPlayerPairsEvent extends PlayersEvent {
  @override
  List<Object?> get props => [];
}

/// Загружает историю сессий конкретной пары игроков.
class LoadSessionsForPairEvent extends PlayersEvent {
  final int pairId;

  LoadSessionsForPairEvent({required this.pairId});

  @override
  List<Object?> get props => [pairId];
}