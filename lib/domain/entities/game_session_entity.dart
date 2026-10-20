

import '../constants/enums.dart';

class GameSessionEntity {
  final int? id;
  final int playerPairId;
  final GameResult result;
  final DateTime playedAt;
  final GameMode gameMode;

  GameSessionEntity({
    this.id,
    required this.playerPairId,
    required this.result,
    required this.playedAt,
    required this.gameMode,
  });

  GameSessionEntity copyWith({
    int? id,
    int? playerPairId,
    GameResult? result,
    DateTime? playedAt,
    GameMode? gameMode,
  }) {
    return GameSessionEntity(
      id: id ?? this.id,
      playerPairId: playerPairId ?? this.playerPairId,
      result: result ?? this.result,
      playedAt: playedAt ?? this.playedAt,
      gameMode: gameMode ?? this.gameMode,
    );
  }
}
