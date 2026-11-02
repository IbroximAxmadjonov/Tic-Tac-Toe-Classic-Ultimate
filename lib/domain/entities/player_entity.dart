import 'package:shared_preferences/shared_preferences.dart';

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
}

Future<String> noPlayerNameWithCounter() async {
  final pref = await SharedPreferences.getInstance();
  final count = pref.getInt('noNameCounter') ?? 1;
  await pref.setInt('noNameCounter', count + 1);
  return 'Player $count';
}

Future<String> noSessionNameWithCounter() async {
  final pref = await SharedPreferences.getInstance();
  final count = pref.getInt('noSessionCounter') ?? 1;
  await pref.setInt('noSessionCounter', count + 1);
  return 'Session $count';
}
