import 'package:drift/drift.dart';

import '../../domain/constants/enums.dart';

class PlayersTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 40)();

  IntColumn get games => integer().withDefault(const Constant(0))();

  IntColumn get wins => integer().withDefault(const Constant(0))();

  IntColumn get losses => integer().withDefault(const Constant(0))();
}

class PlayerPairsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get player1Id =>
      integer().references(PlayersTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get player2Id =>
      integer().references(PlayersTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get games => integer().withDefault(const Constant(0))();

  IntColumn get player1Wins => integer().withDefault(const Constant(0))();

  IntColumn get player2Wins => integer().withDefault(const Constant(0))();

  IntColumn get draws => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastPlayedAt => dateTime().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {player1Id, player2Id},
  ];

  @override
  List<String> get customConstraints => ['CHECK ("player1_id" < "player2_id")'];
}

class GameSessionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get playerPairId =>
      integer().references(PlayerPairsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get result => textEnum<GameResult>()();

  TextColumn get gameMode => textEnum<GameMode>()();

  DateTimeColumn get playedAt => dateTime()();
}
