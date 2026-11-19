class PlayerEntity {
  final int id;
  final String name;
  final int games;
  final int wins;
  final int losses;
  final int draws;

  PlayerEntity({
    required this.id,
    required this.name,
    required this.games,
    required this.wins,
    required this.losses,
    required this.draws,
  });

  PlayerEntity copyWith({
    int? id,
    String? name,
    int? games,
    int? wins,
    int? losses,
    int? draws,
  }) {
    return PlayerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      games: games ?? this.games,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
    );
  }

  factory PlayerEntity.mockPlayerX() {
    return PlayerEntity(
      id: 0,
      name: 'Player X',
      games: 0,
      wins: 0,
      losses: 0,
      draws: 0,
    );
  }

  factory PlayerEntity.mockPlayerO() {
    return PlayerEntity(
      id: 0,
      name: 'Player O',
      games: 0,
      wins: 0,
      losses: 0,
      draws: 0,
    );
  }
}
