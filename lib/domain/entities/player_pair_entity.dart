class PlayerPairEntity {
  final int id;
  final int player1Id;
  final int player2Id;
  final int games;
  final int player1Wins;
  final int player2Wins;
  final int draws;
  final DateTime lastPlayedAt;

  PlayerPairEntity({
    required this.id,
    required this.player1Id,
    required this.player2Id,
    required this.games,
    required this.player1Wins,
    required this.player2Wins,
    required this.draws,
    required this.lastPlayedAt,
  });
}
