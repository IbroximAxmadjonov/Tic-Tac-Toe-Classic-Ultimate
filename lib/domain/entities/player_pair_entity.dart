class PlayerPairEntity {
  final int id;
  final int playerXId;
  final int playerOId;
  final int games;
  final int player1Wins;
  final int player2Wins;
  final int draws;
  final DateTime lastPlayedAt;

  PlayerPairEntity({
    required this.id,
    required this.playerXId,
    required this.playerOId,
    required this.games,
    required this.player1Wins,
    required this.player2Wins,
    required this.draws,
    required this.lastPlayedAt,
  });
}
