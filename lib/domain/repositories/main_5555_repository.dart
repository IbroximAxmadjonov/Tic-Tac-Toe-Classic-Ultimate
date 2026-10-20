// import '../constants/enums.dart';
// import '../entities/game_session_entity.dart';
// import '../entities/player_entity.dart';
// import '../entities/player_pair_entity.dart';
//
// abstract class MainRepository {
//   Future<void> createPlayer({required String name});
//
//   Future<List<PlayerEntity>> getPlayersByRanking();
//
//   Future<PlayerEntity?> getPlayer({required int playerId});
//
//   Future<List<PlayerPairEntity>> getPlayerPairs();
//
//   Future<List<GameSessionEntity>> getSessionsForPair({required int pairId});
//
//   int drawsFor(PlayerEntity player);
//
//   Future<void> recordFinishedGame({
//     required int playerAId,
//     required int playerBId,
//     required int? winnerPlayerId,
//     required GameMode mode,
//     DateTime? playedAt,
//   });
//
//   Future<void> renamePlayer({required int playerId, required String newName});
//
//   Future<void> deletePlayer({required int playerId});
// }
