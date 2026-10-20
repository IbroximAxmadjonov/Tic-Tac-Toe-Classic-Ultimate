// abstract class MainLocaleDataSource {
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