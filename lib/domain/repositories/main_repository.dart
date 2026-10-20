import 'package:drift/drift.dart';
import 'package:tic_tac_toe/domain/entities/game_session_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_pair_entity.dart';

import '../../data/data_base/app_database.dart';
import '../constants/enums.dart';

class MainRepository {
  MainRepository({required this._db});

  final AppDatabase _db;

  /// Creates a player and returns its generated ID.
  Future<int> createPlayer(String name) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Name must not be empty.');
    }

    return _db
        .into(_db.playersTable)
        .insert(PlayersTableCompanion.insert(name: normalizedName));
  }

  Future<List<PlayerEntity>> getPlayersByRanking() async {
    // Wins descending, then fewer losses, then name.
    final result =
        await (_db.select(_db.playersTable)..orderBy([
              (t) => OrderingTerm.desc(t.wins),
              (t) => OrderingTerm.asc(t.losses),
              (t) => OrderingTerm.asc(t.name),
            ]))
            .get();

    return result
        .map(
          (row) => PlayerEntity(
            name: row.name,
            games: row.games,
            wins: row.wins,
            losses: row.losses,
            draws: row.games - row.wins - row.losses,
          ),
        )
        .toList();
  }

  Future<PlayerEntity?> getPlayer(int playerId) async {
    final result = await (_db.select(
      _db.playersTable,
    )..where((t) => t.id.equals(playerId))).getSingleOrNull();
    if (result != null) {
      return PlayerEntity(
        name: result.name,
        games: result.games,
        wins: result.wins,
        losses: result.losses,
        draws: drawsFor(result),
      );
    } else {
      return null;
    }
  }

  int drawsFor(PlayersTableData player) =>
      player.games - player.wins - player.losses;

  /// One row per unordered pair of players.
  ///
  /// Pair aggregate statistics combine all game modes. Individual modes
  /// remain available on each GameSession.
  Future<List<PlayerPairEntity>> getPlayerPairs() async {
    final result = await (_db.select(
      _db.playerPairsTable,
    )..orderBy([(t) => OrderingTerm.desc(t.lastPlayedAt)])).get();
    return result.map((row) {
      return PlayerPairEntity(
        id: row.id,
        player1Id: row.player1Id,
        player2Id: row.player2Id,
        games: row.games,
        player1Wins: row.player1Wins,
        player2Wins: row.player2Wins,
        draws: row.draws,
        lastPlayedAt: row.lastPlayedAt!,
      );
    }).toList();
  }

  /// Returns the full chronological history for one pair.
  Future<List<GameSessionEntity>> getSessionsForPair(int pairId) async {
    final result =
        await (_db.select(_db.gameSessionsTable)
              ..where((t) => t.playerPairId.equals(pairId))
              ..orderBy([
                (t) => OrderingTerm.desc(t.playedAt),
                (t) => OrderingTerm.desc(t.id),
              ]))
            .get();
    return result.map((row) {
      return GameSessionEntity(
        playerPairId: row.playerPairId,
        result: row.result,
        playedAt: row.playedAt,
        gameMode: row.gameMode,
      );
    }).toList();
  }

  /// Records a finished game atomically.
  ///
  /// `winnerPlayerId == null` means draw. The winner must be one of the
  /// two participants. A player cannot play against themselves.
  ///
  /// IMPORTANT: invoke once for each genuinely finished game, not on every
  /// rebuild or repeated state emission.
  Future<int> recordFinishedGame({
    required int playerAId,
    required int playerBId,
    required int? winnerPlayerId,
    required GameMode mode,
    DateTime? playedAt,
  }) {
    if (playerAId == playerBId) {
      throw ArgumentError('A player cannot play against themselves.');
    }

    if (winnerPlayerId != null &&
        winnerPlayerId != playerAId &&
        winnerPlayerId != playerBId) {
      throw ArgumentError('Winner must be one of the two participants.');
    }

    final firstId = playerAId < playerBId ? playerAId : playerBId;
    final secondId = playerAId < playerBId ? playerBId : playerAId;
    final timestamp = playedAt ?? DateTime.now();

    return _db.transaction(() async {
      final firstPlayer = await (_db.select(
        _db.playersTable,
      )..where((t) => t.id.equals(firstId))).getSingleOrNull();
      final secondPlayer = await (_db.select(
        _db.playersTable,
      )..where((t) => t.id.equals(secondId))).getSingleOrNull();

      if (firstPlayer == null || secondPlayer == null) {
        throw StateError('Both players must exist before recording a game.');
      }

      // Update player totals.
      await (_db.update(_db.playersTable)..where((t) => t.id.equals(firstId))).write(
        PlayersTableCompanion(
          games: Value(firstPlayer.games + 1),
          wins: Value(firstPlayer.wins + (winnerPlayerId == firstId ? 1 : 0)),
          losses: Value(firstPlayer.losses + (winnerPlayerId == secondId ? 1 : 0)),
        ),
      );

      await (_db.update(
        _db.playersTable,
      )..where((t) => t.id.equals(secondId))).write(
        PlayersTableCompanion(
          games: Value(secondPlayer.games + 1),
          wins: Value(secondPlayer.wins + (winnerPlayerId == secondId ? 1 : 0)),
          losses: Value(secondPlayer.losses + (winnerPlayerId == firstId ? 1 : 0)),
        ),
      );

      // Find or create the canonical pair.
      final existingPair =
          await (_db.select(_db.playerPairsTable)..where(
                (t) => t.player1Id.equals(firstId) & t.player2Id.equals(secondId),
              ))
              .getSingleOrNull();

      final pairId =
          existingPair?.id ??
          await _db
              .into(_db.playerPairsTable)
              .insert(
                PlayerPairsTableCompanion.insert(
                  player1Id: firstId,
                  player2Id: secondId,
                ),
              );

      final currentPair =
          existingPair ??
          await (_db.select(
            _db.playerPairsTable,
          )..where((t) => t.id.equals(pairId))).getSingle();

      final result = winnerPlayerId == null
          ? GameResult.draw
          : winnerPlayerId == firstId
          ? GameResult.player1Won
          : GameResult.player2Won;

      await (_db.update(
        _db.playerPairsTable,
      )..where((t) => t.id.equals(pairId))).write(
        PlayerPairsTableCompanion(
          games: Value(currentPair.games + 1),
          player1Wins: Value(
            currentPair.player1Wins + (result == GameResult.player1Won ? 1 : 0),
          ),
          player2Wins: Value(
            currentPair.player2Wins + (result == GameResult.player2Won ? 1 : 0),
          ),
          draws: Value(currentPair.draws + (result == GameResult.draw ? 1 : 0)),
          lastPlayedAt: Value(timestamp),
        ),
      );

      // Store result relative to the canonical pair order.
      return _db
          .into(_db.gameSessionsTable)
          .insert(
            GameSessionsTableCompanion.insert(
              playerPairId: pairId,
              result: result,
              gameMode: mode,
              playedAt: timestamp,
            ),
          );
    });
  }

  /// Renaming a player does not break history because relationships use IDs.
  Future<void> renamePlayer({required int playerId, required String newName}) async {
    final normalizedName = newName.trim();
    if (normalizedName.isEmpty) {
      throw ArgumentError.value(newName, 'newName', 'Name must not be empty.');
    }

    await (_db.update(_db.playersTable)..where((t) => t.id.equals(playerId))).write(
      PlayersTableCompanion(name: Value(normalizedName)),
    );
  }

  Future<void> deletePlayer(int playerId) async {
    await (_db.delete(_db.playersTable)..where((t) => t.id.equals(playerId))).go();
    // Foreign-key cascade removes pair records and their game history.
  }
}
