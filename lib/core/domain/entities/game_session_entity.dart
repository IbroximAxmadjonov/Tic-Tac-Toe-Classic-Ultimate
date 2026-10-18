import 'package:tic_tac_toe/core/domain/entities/player_entity.dart';

class GameSessionEntity {
  final int? id;
  final String sessionName;
  final PlayerEntity xPlayer;
  final PlayerEntity oPlayer;
  final bool oTurn;
  final DateTime lastGame;

  GameSessionEntity({
    this.id,
    required this.sessionName,
    required this.xPlayer,
    required this.oPlayer,
    this.oTurn = false,
    required this.lastGame,
  });

  GameSessionEntity copyWith({
    int? id,
    String? sessionName,
    PlayerEntity? xPlayer,
    PlayerEntity? oPlayer,
    bool? oTurn,
    DateTime? lastGame,
  }) {
    return GameSessionEntity(
      id: id ?? this.id,
      sessionName: sessionName ?? this.sessionName,
      xPlayer: xPlayer ?? this.xPlayer,
      oPlayer: oPlayer ?? this.oPlayer,
      oTurn: oTurn ?? this.oTurn,
      lastGame: lastGame ?? this.lastGame,
    );
  }
}
