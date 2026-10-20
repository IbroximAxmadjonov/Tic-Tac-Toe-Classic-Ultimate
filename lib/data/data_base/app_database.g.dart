// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlayersTableTable extends PlayersTable
    with TableInfo<$PlayersTableTable, PlayersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gamesMeta = const VerificationMeta('games');
  @override
  late final GeneratedColumn<int> games = GeneratedColumn<int>(
    'games',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _winsMeta = const VerificationMeta('wins');
  @override
  late final GeneratedColumn<int> wins = GeneratedColumn<int>(
    'wins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lossesMeta = const VerificationMeta('losses');
  @override
  late final GeneratedColumn<int> losses = GeneratedColumn<int>(
    'losses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, games, wins, losses];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('games')) {
      context.handle(
        _gamesMeta,
        games.isAcceptableOrUnknown(data['games']!, _gamesMeta),
      );
    }
    if (data.containsKey('wins')) {
      context.handle(
        _winsMeta,
        wins.isAcceptableOrUnknown(data['wins']!, _winsMeta),
      );
    }
    if (data.containsKey('losses')) {
      context.handle(
        _lossesMeta,
        losses.isAcceptableOrUnknown(data['losses']!, _lossesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      games: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}games'],
      )!,
      wins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wins'],
      )!,
      losses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}losses'],
      )!,
    );
  }

  @override
  $PlayersTableTable createAlias(String alias) {
    return $PlayersTableTable(attachedDatabase, alias);
  }
}

class PlayersTableData extends DataClass
    implements Insertable<PlayersTableData> {
  final int id;
  final String name;
  final int games;
  final int wins;
  final int losses;
  const PlayersTableData({
    required this.id,
    required this.name,
    required this.games,
    required this.wins,
    required this.losses,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['games'] = Variable<int>(games);
    map['wins'] = Variable<int>(wins);
    map['losses'] = Variable<int>(losses);
    return map;
  }

  PlayersTableCompanion toCompanion(bool nullToAbsent) {
    return PlayersTableCompanion(
      id: Value(id),
      name: Value(name),
      games: Value(games),
      wins: Value(wins),
      losses: Value(losses),
    );
  }

  factory PlayersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayersTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      games: serializer.fromJson<int>(json['games']),
      wins: serializer.fromJson<int>(json['wins']),
      losses: serializer.fromJson<int>(json['losses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'games': serializer.toJson<int>(games),
      'wins': serializer.toJson<int>(wins),
      'losses': serializer.toJson<int>(losses),
    };
  }

  PlayersTableData copyWith({
    int? id,
    String? name,
    int? games,
    int? wins,
    int? losses,
  }) => PlayersTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    games: games ?? this.games,
    wins: wins ?? this.wins,
    losses: losses ?? this.losses,
  );
  PlayersTableData copyWithCompanion(PlayersTableCompanion data) {
    return PlayersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      games: data.games.present ? data.games.value : this.games,
      wins: data.wins.present ? data.wins.value : this.wins,
      losses: data.losses.present ? data.losses.value : this.losses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('games: $games, ')
          ..write('wins: $wins, ')
          ..write('losses: $losses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, games, wins, losses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.games == this.games &&
          other.wins == this.wins &&
          other.losses == this.losses);
}

class PlayersTableCompanion extends UpdateCompanion<PlayersTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> games;
  final Value<int> wins;
  final Value<int> losses;
  const PlayersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.games = const Value.absent(),
    this.wins = const Value.absent(),
    this.losses = const Value.absent(),
  });
  PlayersTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.games = const Value.absent(),
    this.wins = const Value.absent(),
    this.losses = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlayersTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? games,
    Expression<int>? wins,
    Expression<int>? losses,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (games != null) 'games': games,
      if (wins != null) 'wins': wins,
      if (losses != null) 'losses': losses,
    });
  }

  PlayersTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? games,
    Value<int>? wins,
    Value<int>? losses,
  }) {
    return PlayersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      games: games ?? this.games,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (games.present) {
      map['games'] = Variable<int>(games.value);
    }
    if (wins.present) {
      map['wins'] = Variable<int>(wins.value);
    }
    if (losses.present) {
      map['losses'] = Variable<int>(losses.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('games: $games, ')
          ..write('wins: $wins, ')
          ..write('losses: $losses')
          ..write(')'))
        .toString();
  }
}

class $PlayerPairsTableTable extends PlayerPairsTable
    with TableInfo<$PlayerPairsTableTable, PlayerPairsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerPairsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _player1IdMeta = const VerificationMeta(
    'player1Id',
  );
  @override
  late final GeneratedColumn<int> player1Id = GeneratedColumn<int>(
    'player1_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _player2IdMeta = const VerificationMeta(
    'player2Id',
  );
  @override
  late final GeneratedColumn<int> player2Id = GeneratedColumn<int>(
    'player2_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gamesMeta = const VerificationMeta('games');
  @override
  late final GeneratedColumn<int> games = GeneratedColumn<int>(
    'games',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _player1WinsMeta = const VerificationMeta(
    'player1Wins',
  );
  @override
  late final GeneratedColumn<int> player1Wins = GeneratedColumn<int>(
    'player1_wins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _player2WinsMeta = const VerificationMeta(
    'player2Wins',
  );
  @override
  late final GeneratedColumn<int> player2Wins = GeneratedColumn<int>(
    'player2_wins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _drawsMeta = const VerificationMeta('draws');
  @override
  late final GeneratedColumn<int> draws = GeneratedColumn<int>(
    'draws',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastPlayedAtMeta = const VerificationMeta(
    'lastPlayedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPlayedAt = GeneratedColumn<DateTime>(
    'last_played_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    player1Id,
    player2Id,
    games,
    player1Wins,
    player2Wins,
    draws,
    lastPlayedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_pairs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerPairsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player1_id')) {
      context.handle(
        _player1IdMeta,
        player1Id.isAcceptableOrUnknown(data['player1_id']!, _player1IdMeta),
      );
    } else if (isInserting) {
      context.missing(_player1IdMeta);
    }
    if (data.containsKey('player2_id')) {
      context.handle(
        _player2IdMeta,
        player2Id.isAcceptableOrUnknown(data['player2_id']!, _player2IdMeta),
      );
    } else if (isInserting) {
      context.missing(_player2IdMeta);
    }
    if (data.containsKey('games')) {
      context.handle(
        _gamesMeta,
        games.isAcceptableOrUnknown(data['games']!, _gamesMeta),
      );
    }
    if (data.containsKey('player1_wins')) {
      context.handle(
        _player1WinsMeta,
        player1Wins.isAcceptableOrUnknown(
          data['player1_wins']!,
          _player1WinsMeta,
        ),
      );
    }
    if (data.containsKey('player2_wins')) {
      context.handle(
        _player2WinsMeta,
        player2Wins.isAcceptableOrUnknown(
          data['player2_wins']!,
          _player2WinsMeta,
        ),
      );
    }
    if (data.containsKey('draws')) {
      context.handle(
        _drawsMeta,
        draws.isAcceptableOrUnknown(data['draws']!, _drawsMeta),
      );
    }
    if (data.containsKey('last_played_at')) {
      context.handle(
        _lastPlayedAtMeta,
        lastPlayedAt.isAcceptableOrUnknown(
          data['last_played_at']!,
          _lastPlayedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {player1Id, player2Id},
  ];
  @override
  PlayerPairsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerPairsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      player1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player1_id'],
      )!,
      player2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player2_id'],
      )!,
      games: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}games'],
      )!,
      player1Wins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player1_wins'],
      )!,
      player2Wins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player2_wins'],
      )!,
      draws: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}draws'],
      )!,
      lastPlayedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_played_at'],
      ),
    );
  }

  @override
  $PlayerPairsTableTable createAlias(String alias) {
    return $PlayerPairsTableTable(attachedDatabase, alias);
  }
}

class PlayerPairsTableData extends DataClass
    implements Insertable<PlayerPairsTableData> {
  final int id;
  final int player1Id;
  final int player2Id;
  final int games;
  final int player1Wins;
  final int player2Wins;
  final int draws;
  final DateTime? lastPlayedAt;
  const PlayerPairsTableData({
    required this.id,
    required this.player1Id,
    required this.player2Id,
    required this.games,
    required this.player1Wins,
    required this.player2Wins,
    required this.draws,
    this.lastPlayedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player1_id'] = Variable<int>(player1Id);
    map['player2_id'] = Variable<int>(player2Id);
    map['games'] = Variable<int>(games);
    map['player1_wins'] = Variable<int>(player1Wins);
    map['player2_wins'] = Variable<int>(player2Wins);
    map['draws'] = Variable<int>(draws);
    if (!nullToAbsent || lastPlayedAt != null) {
      map['last_played_at'] = Variable<DateTime>(lastPlayedAt);
    }
    return map;
  }

  PlayerPairsTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerPairsTableCompanion(
      id: Value(id),
      player1Id: Value(player1Id),
      player2Id: Value(player2Id),
      games: Value(games),
      player1Wins: Value(player1Wins),
      player2Wins: Value(player2Wins),
      draws: Value(draws),
      lastPlayedAt: lastPlayedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlayedAt),
    );
  }

  factory PlayerPairsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerPairsTableData(
      id: serializer.fromJson<int>(json['id']),
      player1Id: serializer.fromJson<int>(json['player1Id']),
      player2Id: serializer.fromJson<int>(json['player2Id']),
      games: serializer.fromJson<int>(json['games']),
      player1Wins: serializer.fromJson<int>(json['player1Wins']),
      player2Wins: serializer.fromJson<int>(json['player2Wins']),
      draws: serializer.fromJson<int>(json['draws']),
      lastPlayedAt: serializer.fromJson<DateTime?>(json['lastPlayedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'player1Id': serializer.toJson<int>(player1Id),
      'player2Id': serializer.toJson<int>(player2Id),
      'games': serializer.toJson<int>(games),
      'player1Wins': serializer.toJson<int>(player1Wins),
      'player2Wins': serializer.toJson<int>(player2Wins),
      'draws': serializer.toJson<int>(draws),
      'lastPlayedAt': serializer.toJson<DateTime?>(lastPlayedAt),
    };
  }

  PlayerPairsTableData copyWith({
    int? id,
    int? player1Id,
    int? player2Id,
    int? games,
    int? player1Wins,
    int? player2Wins,
    int? draws,
    Value<DateTime?> lastPlayedAt = const Value.absent(),
  }) => PlayerPairsTableData(
    id: id ?? this.id,
    player1Id: player1Id ?? this.player1Id,
    player2Id: player2Id ?? this.player2Id,
    games: games ?? this.games,
    player1Wins: player1Wins ?? this.player1Wins,
    player2Wins: player2Wins ?? this.player2Wins,
    draws: draws ?? this.draws,
    lastPlayedAt: lastPlayedAt.present ? lastPlayedAt.value : this.lastPlayedAt,
  );
  PlayerPairsTableData copyWithCompanion(PlayerPairsTableCompanion data) {
    return PlayerPairsTableData(
      id: data.id.present ? data.id.value : this.id,
      player1Id: data.player1Id.present ? data.player1Id.value : this.player1Id,
      player2Id: data.player2Id.present ? data.player2Id.value : this.player2Id,
      games: data.games.present ? data.games.value : this.games,
      player1Wins: data.player1Wins.present
          ? data.player1Wins.value
          : this.player1Wins,
      player2Wins: data.player2Wins.present
          ? data.player2Wins.value
          : this.player2Wins,
      draws: data.draws.present ? data.draws.value : this.draws,
      lastPlayedAt: data.lastPlayedAt.present
          ? data.lastPlayedAt.value
          : this.lastPlayedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerPairsTableData(')
          ..write('id: $id, ')
          ..write('player1Id: $player1Id, ')
          ..write('player2Id: $player2Id, ')
          ..write('games: $games, ')
          ..write('player1Wins: $player1Wins, ')
          ..write('player2Wins: $player2Wins, ')
          ..write('draws: $draws, ')
          ..write('lastPlayedAt: $lastPlayedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    player1Id,
    player2Id,
    games,
    player1Wins,
    player2Wins,
    draws,
    lastPlayedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerPairsTableData &&
          other.id == this.id &&
          other.player1Id == this.player1Id &&
          other.player2Id == this.player2Id &&
          other.games == this.games &&
          other.player1Wins == this.player1Wins &&
          other.player2Wins == this.player2Wins &&
          other.draws == this.draws &&
          other.lastPlayedAt == this.lastPlayedAt);
}

class PlayerPairsTableCompanion extends UpdateCompanion<PlayerPairsTableData> {
  final Value<int> id;
  final Value<int> player1Id;
  final Value<int> player2Id;
  final Value<int> games;
  final Value<int> player1Wins;
  final Value<int> player2Wins;
  final Value<int> draws;
  final Value<DateTime?> lastPlayedAt;
  const PlayerPairsTableCompanion({
    this.id = const Value.absent(),
    this.player1Id = const Value.absent(),
    this.player2Id = const Value.absent(),
    this.games = const Value.absent(),
    this.player1Wins = const Value.absent(),
    this.player2Wins = const Value.absent(),
    this.draws = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
  });
  PlayerPairsTableCompanion.insert({
    this.id = const Value.absent(),
    required int player1Id,
    required int player2Id,
    this.games = const Value.absent(),
    this.player1Wins = const Value.absent(),
    this.player2Wins = const Value.absent(),
    this.draws = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
  }) : player1Id = Value(player1Id),
       player2Id = Value(player2Id);
  static Insertable<PlayerPairsTableData> custom({
    Expression<int>? id,
    Expression<int>? player1Id,
    Expression<int>? player2Id,
    Expression<int>? games,
    Expression<int>? player1Wins,
    Expression<int>? player2Wins,
    Expression<int>? draws,
    Expression<DateTime>? lastPlayedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (player1Id != null) 'player1_id': player1Id,
      if (player2Id != null) 'player2_id': player2Id,
      if (games != null) 'games': games,
      if (player1Wins != null) 'player1_wins': player1Wins,
      if (player2Wins != null) 'player2_wins': player2Wins,
      if (draws != null) 'draws': draws,
      if (lastPlayedAt != null) 'last_played_at': lastPlayedAt,
    });
  }

  PlayerPairsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? player1Id,
    Value<int>? player2Id,
    Value<int>? games,
    Value<int>? player1Wins,
    Value<int>? player2Wins,
    Value<int>? draws,
    Value<DateTime?>? lastPlayedAt,
  }) {
    return PlayerPairsTableCompanion(
      id: id ?? this.id,
      player1Id: player1Id ?? this.player1Id,
      player2Id: player2Id ?? this.player2Id,
      games: games ?? this.games,
      player1Wins: player1Wins ?? this.player1Wins,
      player2Wins: player2Wins ?? this.player2Wins,
      draws: draws ?? this.draws,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (player1Id.present) {
      map['player1_id'] = Variable<int>(player1Id.value);
    }
    if (player2Id.present) {
      map['player2_id'] = Variable<int>(player2Id.value);
    }
    if (games.present) {
      map['games'] = Variable<int>(games.value);
    }
    if (player1Wins.present) {
      map['player1_wins'] = Variable<int>(player1Wins.value);
    }
    if (player2Wins.present) {
      map['player2_wins'] = Variable<int>(player2Wins.value);
    }
    if (draws.present) {
      map['draws'] = Variable<int>(draws.value);
    }
    if (lastPlayedAt.present) {
      map['last_played_at'] = Variable<DateTime>(lastPlayedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerPairsTableCompanion(')
          ..write('id: $id, ')
          ..write('player1Id: $player1Id, ')
          ..write('player2Id: $player2Id, ')
          ..write('games: $games, ')
          ..write('player1Wins: $player1Wins, ')
          ..write('player2Wins: $player2Wins, ')
          ..write('draws: $draws, ')
          ..write('lastPlayedAt: $lastPlayedAt')
          ..write(')'))
        .toString();
  }
}

class $GameSessionsTableTable extends GameSessionsTable
    with TableInfo<$GameSessionsTableTable, GameSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerPairIdMeta = const VerificationMeta(
    'playerPairId',
  );
  @override
  late final GeneratedColumn<int> playerPairId = GeneratedColumn<int>(
    'player_pair_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GameResult, String> result =
      GeneratedColumn<String>(
        'result',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GameResult>($GameSessionsTableTable.$converterresult);
  @override
  late final GeneratedColumnWithTypeConverter<GameMode, String> gameMode =
      GeneratedColumn<String>(
        'game_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GameMode>($GameSessionsTableTable.$convertergameMode);
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerPairId,
    result,
    gameMode,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameSessionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_pair_id')) {
      context.handle(
        _playerPairIdMeta,
        playerPairId.isAcceptableOrUnknown(
          data['player_pair_id']!,
          _playerPairIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_playerPairIdMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameSessionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameSessionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerPairId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_pair_id'],
      )!,
      result: $GameSessionsTableTable.$converterresult.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}result'],
        )!,
      ),
      gameMode: $GameSessionsTableTable.$convertergameMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}game_mode'],
        )!,
      ),
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $GameSessionsTableTable createAlias(String alias) {
    return $GameSessionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GameResult, String, String> $converterresult =
      const EnumNameConverter<GameResult>(GameResult.values);
  static JsonTypeConverter2<GameMode, String, String> $convertergameMode =
      const EnumNameConverter<GameMode>(GameMode.values);
}

class GameSessionsTableData extends DataClass
    implements Insertable<GameSessionsTableData> {
  final int id;
  final int playerPairId;
  final GameResult result;
  final GameMode gameMode;
  final DateTime playedAt;
  const GameSessionsTableData({
    required this.id,
    required this.playerPairId,
    required this.result,
    required this.gameMode,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_pair_id'] = Variable<int>(playerPairId);
    {
      map['result'] = Variable<String>(
        $GameSessionsTableTable.$converterresult.toSql(result),
      );
    }
    {
      map['game_mode'] = Variable<String>(
        $GameSessionsTableTable.$convertergameMode.toSql(gameMode),
      );
    }
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  GameSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return GameSessionsTableCompanion(
      id: Value(id),
      playerPairId: Value(playerPairId),
      result: Value(result),
      gameMode: Value(gameMode),
      playedAt: Value(playedAt),
    );
  }

  factory GameSessionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameSessionsTableData(
      id: serializer.fromJson<int>(json['id']),
      playerPairId: serializer.fromJson<int>(json['playerPairId']),
      result: $GameSessionsTableTable.$converterresult.fromJson(
        serializer.fromJson<String>(json['result']),
      ),
      gameMode: $GameSessionsTableTable.$convertergameMode.fromJson(
        serializer.fromJson<String>(json['gameMode']),
      ),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerPairId': serializer.toJson<int>(playerPairId),
      'result': serializer.toJson<String>(
        $GameSessionsTableTable.$converterresult.toJson(result),
      ),
      'gameMode': serializer.toJson<String>(
        $GameSessionsTableTable.$convertergameMode.toJson(gameMode),
      ),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  GameSessionsTableData copyWith({
    int? id,
    int? playerPairId,
    GameResult? result,
    GameMode? gameMode,
    DateTime? playedAt,
  }) => GameSessionsTableData(
    id: id ?? this.id,
    playerPairId: playerPairId ?? this.playerPairId,
    result: result ?? this.result,
    gameMode: gameMode ?? this.gameMode,
    playedAt: playedAt ?? this.playedAt,
  );
  GameSessionsTableData copyWithCompanion(GameSessionsTableCompanion data) {
    return GameSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      playerPairId: data.playerPairId.present
          ? data.playerPairId.value
          : this.playerPairId,
      result: data.result.present ? data.result.value : this.result,
      gameMode: data.gameMode.present ? data.gameMode.value : this.gameMode,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionsTableData(')
          ..write('id: $id, ')
          ..write('playerPairId: $playerPairId, ')
          ..write('result: $result, ')
          ..write('gameMode: $gameMode, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playerPairId, result, gameMode, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameSessionsTableData &&
          other.id == this.id &&
          other.playerPairId == this.playerPairId &&
          other.result == this.result &&
          other.gameMode == this.gameMode &&
          other.playedAt == this.playedAt);
}

class GameSessionsTableCompanion
    extends UpdateCompanion<GameSessionsTableData> {
  final Value<int> id;
  final Value<int> playerPairId;
  final Value<GameResult> result;
  final Value<GameMode> gameMode;
  final Value<DateTime> playedAt;
  const GameSessionsTableCompanion({
    this.id = const Value.absent(),
    this.playerPairId = const Value.absent(),
    this.result = const Value.absent(),
    this.gameMode = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  GameSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    required int playerPairId,
    required GameResult result,
    required GameMode gameMode,
    required DateTime playedAt,
  }) : playerPairId = Value(playerPairId),
       result = Value(result),
       gameMode = Value(gameMode),
       playedAt = Value(playedAt);
  static Insertable<GameSessionsTableData> custom({
    Expression<int>? id,
    Expression<int>? playerPairId,
    Expression<String>? result,
    Expression<String>? gameMode,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerPairId != null) 'player_pair_id': playerPairId,
      if (result != null) 'result': result,
      if (gameMode != null) 'game_mode': gameMode,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  GameSessionsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? playerPairId,
    Value<GameResult>? result,
    Value<GameMode>? gameMode,
    Value<DateTime>? playedAt,
  }) {
    return GameSessionsTableCompanion(
      id: id ?? this.id,
      playerPairId: playerPairId ?? this.playerPairId,
      result: result ?? this.result,
      gameMode: gameMode ?? this.gameMode,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerPairId.present) {
      map['player_pair_id'] = Variable<int>(playerPairId.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(
        $GameSessionsTableTable.$converterresult.toSql(result.value),
      );
    }
    if (gameMode.present) {
      map['game_mode'] = Variable<String>(
        $GameSessionsTableTable.$convertergameMode.toSql(gameMode.value),
      );
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('playerPairId: $playerPairId, ')
          ..write('result: $result, ')
          ..write('gameMode: $gameMode, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTableTable playersTable = $PlayersTableTable(this);
  late final $PlayerPairsTableTable playerPairsTable = $PlayerPairsTableTable(
    this,
  );
  late final $GameSessionsTableTable gameSessionsTable =
      $GameSessionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    playersTable,
    playerPairsTable,
    gameSessionsTable,
  ];
}

typedef $$PlayersTableTableCreateCompanionBuilder =
    PlayersTableCompanion Function({
      Value<int> id,
      required String name,
      Value<int> games,
      Value<int> wins,
      Value<int> losses,
    });
typedef $$PlayersTableTableUpdateCompanionBuilder =
    PlayersTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> games,
      Value<int> wins,
      Value<int> losses,
    });

class $$PlayersTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get games => $composableBuilder(
    column: $table.games,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wins => $composableBuilder(
    column: $table.wins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get games => $composableBuilder(
    column: $table.games,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wins => $composableBuilder(
    column: $table.wins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTableTable> {
  $$PlayersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get games =>
      $composableBuilder(column: $table.games, builder: (column) => column);

  GeneratedColumn<int> get wins =>
      $composableBuilder(column: $table.wins, builder: (column) => column);

  GeneratedColumn<int> get losses =>
      $composableBuilder(column: $table.losses, builder: (column) => column);
}

class $$PlayersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTableTable,
          PlayersTableData,
          $$PlayersTableTableFilterComposer,
          $$PlayersTableTableOrderingComposer,
          $$PlayersTableTableAnnotationComposer,
          $$PlayersTableTableCreateCompanionBuilder,
          $$PlayersTableTableUpdateCompanionBuilder,
          (
            PlayersTableData,
            BaseReferences<_$AppDatabase, $PlayersTableTable, PlayersTableData>,
          ),
          PlayersTableData,
          PrefetchHooks Function()
        > {
  $$PlayersTableTableTableManager(_$AppDatabase db, $PlayersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> games = const Value.absent(),
                Value<int> wins = const Value.absent(),
                Value<int> losses = const Value.absent(),
              }) => PlayersTableCompanion(
                id: id,
                name: name,
                games: games,
                wins: wins,
                losses: losses,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> games = const Value.absent(),
                Value<int> wins = const Value.absent(),
                Value<int> losses = const Value.absent(),
              }) => PlayersTableCompanion.insert(
                id: id,
                name: name,
                games: games,
                wins: wins,
                losses: losses,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTableTable,
      PlayersTableData,
      $$PlayersTableTableFilterComposer,
      $$PlayersTableTableOrderingComposer,
      $$PlayersTableTableAnnotationComposer,
      $$PlayersTableTableCreateCompanionBuilder,
      $$PlayersTableTableUpdateCompanionBuilder,
      (
        PlayersTableData,
        BaseReferences<_$AppDatabase, $PlayersTableTable, PlayersTableData>,
      ),
      PlayersTableData,
      PrefetchHooks Function()
    >;
typedef $$PlayerPairsTableTableCreateCompanionBuilder =
    PlayerPairsTableCompanion Function({
      Value<int> id,
      required int player1Id,
      required int player2Id,
      Value<int> games,
      Value<int> player1Wins,
      Value<int> player2Wins,
      Value<int> draws,
      Value<DateTime?> lastPlayedAt,
    });
typedef $$PlayerPairsTableTableUpdateCompanionBuilder =
    PlayerPairsTableCompanion Function({
      Value<int> id,
      Value<int> player1Id,
      Value<int> player2Id,
      Value<int> games,
      Value<int> player1Wins,
      Value<int> player2Wins,
      Value<int> draws,
      Value<DateTime?> lastPlayedAt,
    });

class $$PlayerPairsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerPairsTableTable> {
  $$PlayerPairsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get player1Id => $composableBuilder(
    column: $table.player1Id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get player2Id => $composableBuilder(
    column: $table.player2Id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get games => $composableBuilder(
    column: $table.games,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get player1Wins => $composableBuilder(
    column: $table.player1Wins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get player2Wins => $composableBuilder(
    column: $table.player2Wins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get draws => $composableBuilder(
    column: $table.draws,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayerPairsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerPairsTableTable> {
  $$PlayerPairsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get player1Id => $composableBuilder(
    column: $table.player1Id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get player2Id => $composableBuilder(
    column: $table.player2Id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get games => $composableBuilder(
    column: $table.games,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get player1Wins => $composableBuilder(
    column: $table.player1Wins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get player2Wins => $composableBuilder(
    column: $table.player2Wins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get draws => $composableBuilder(
    column: $table.draws,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayerPairsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerPairsTableTable> {
  $$PlayerPairsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get player1Id =>
      $composableBuilder(column: $table.player1Id, builder: (column) => column);

  GeneratedColumn<int> get player2Id =>
      $composableBuilder(column: $table.player2Id, builder: (column) => column);

  GeneratedColumn<int> get games =>
      $composableBuilder(column: $table.games, builder: (column) => column);

  GeneratedColumn<int> get player1Wins => $composableBuilder(
    column: $table.player1Wins,
    builder: (column) => column,
  );

  GeneratedColumn<int> get player2Wins => $composableBuilder(
    column: $table.player2Wins,
    builder: (column) => column,
  );

  GeneratedColumn<int> get draws =>
      $composableBuilder(column: $table.draws, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => column,
  );
}

class $$PlayerPairsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerPairsTableTable,
          PlayerPairsTableData,
          $$PlayerPairsTableTableFilterComposer,
          $$PlayerPairsTableTableOrderingComposer,
          $$PlayerPairsTableTableAnnotationComposer,
          $$PlayerPairsTableTableCreateCompanionBuilder,
          $$PlayerPairsTableTableUpdateCompanionBuilder,
          (
            PlayerPairsTableData,
            BaseReferences<
              _$AppDatabase,
              $PlayerPairsTableTable,
              PlayerPairsTableData
            >,
          ),
          PlayerPairsTableData,
          PrefetchHooks Function()
        > {
  $$PlayerPairsTableTableTableManager(
    _$AppDatabase db,
    $PlayerPairsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerPairsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerPairsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerPairsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> player1Id = const Value.absent(),
                Value<int> player2Id = const Value.absent(),
                Value<int> games = const Value.absent(),
                Value<int> player1Wins = const Value.absent(),
                Value<int> player2Wins = const Value.absent(),
                Value<int> draws = const Value.absent(),
                Value<DateTime?> lastPlayedAt = const Value.absent(),
              }) => PlayerPairsTableCompanion(
                id: id,
                player1Id: player1Id,
                player2Id: player2Id,
                games: games,
                player1Wins: player1Wins,
                player2Wins: player2Wins,
                draws: draws,
                lastPlayedAt: lastPlayedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int player1Id,
                required int player2Id,
                Value<int> games = const Value.absent(),
                Value<int> player1Wins = const Value.absent(),
                Value<int> player2Wins = const Value.absent(),
                Value<int> draws = const Value.absent(),
                Value<DateTime?> lastPlayedAt = const Value.absent(),
              }) => PlayerPairsTableCompanion.insert(
                id: id,
                player1Id: player1Id,
                player2Id: player2Id,
                games: games,
                player1Wins: player1Wins,
                player2Wins: player2Wins,
                draws: draws,
                lastPlayedAt: lastPlayedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayerPairsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerPairsTableTable,
      PlayerPairsTableData,
      $$PlayerPairsTableTableFilterComposer,
      $$PlayerPairsTableTableOrderingComposer,
      $$PlayerPairsTableTableAnnotationComposer,
      $$PlayerPairsTableTableCreateCompanionBuilder,
      $$PlayerPairsTableTableUpdateCompanionBuilder,
      (
        PlayerPairsTableData,
        BaseReferences<
          _$AppDatabase,
          $PlayerPairsTableTable,
          PlayerPairsTableData
        >,
      ),
      PlayerPairsTableData,
      PrefetchHooks Function()
    >;
typedef $$GameSessionsTableTableCreateCompanionBuilder =
    GameSessionsTableCompanion Function({
      Value<int> id,
      required int playerPairId,
      required GameResult result,
      required GameMode gameMode,
      required DateTime playedAt,
    });
typedef $$GameSessionsTableTableUpdateCompanionBuilder =
    GameSessionsTableCompanion Function({
      Value<int> id,
      Value<int> playerPairId,
      Value<GameResult> result,
      Value<GameMode> gameMode,
      Value<DateTime> playedAt,
    });

class $$GameSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playerPairId => $composableBuilder(
    column: $table.playerPairId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GameResult, GameResult, String> get result =>
      $composableBuilder(
        column: $table.result,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<GameMode, GameMode, String> get gameMode =>
      $composableBuilder(
        column: $table.gameMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GameSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playerPairId => $composableBuilder(
    column: $table.playerPairId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameMode => $composableBuilder(
    column: $table.gameMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameSessionsTableTable> {
  $$GameSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get playerPairId => $composableBuilder(
    column: $table.playerPairId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<GameResult, String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GameMode, String> get gameMode =>
      $composableBuilder(column: $table.gameMode, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$GameSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameSessionsTableTable,
          GameSessionsTableData,
          $$GameSessionsTableTableFilterComposer,
          $$GameSessionsTableTableOrderingComposer,
          $$GameSessionsTableTableAnnotationComposer,
          $$GameSessionsTableTableCreateCompanionBuilder,
          $$GameSessionsTableTableUpdateCompanionBuilder,
          (
            GameSessionsTableData,
            BaseReferences<
              _$AppDatabase,
              $GameSessionsTableTable,
              GameSessionsTableData
            >,
          ),
          GameSessionsTableData,
          PrefetchHooks Function()
        > {
  $$GameSessionsTableTableTableManager(
    _$AppDatabase db,
    $GameSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerPairId = const Value.absent(),
                Value<GameResult> result = const Value.absent(),
                Value<GameMode> gameMode = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => GameSessionsTableCompanion(
                id: id,
                playerPairId: playerPairId,
                result: result,
                gameMode: gameMode,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerPairId,
                required GameResult result,
                required GameMode gameMode,
                required DateTime playedAt,
              }) => GameSessionsTableCompanion.insert(
                id: id,
                playerPairId: playerPairId,
                result: result,
                gameMode: gameMode,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GameSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameSessionsTableTable,
      GameSessionsTableData,
      $$GameSessionsTableTableFilterComposer,
      $$GameSessionsTableTableOrderingComposer,
      $$GameSessionsTableTableAnnotationComposer,
      $$GameSessionsTableTableCreateCompanionBuilder,
      $$GameSessionsTableTableUpdateCompanionBuilder,
      (
        GameSessionsTableData,
        BaseReferences<
          _$AppDatabase,
          $GameSessionsTableTable,
          GameSessionsTableData
        >,
      ),
      GameSessionsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableTableManager get playersTable =>
      $$PlayersTableTableTableManager(_db, _db.playersTable);
  $$PlayerPairsTableTableTableManager get playerPairsTable =>
      $$PlayerPairsTableTableTableManager(_db, _db.playerPairsTable);
  $$GameSessionsTableTableTableManager get gameSessionsTable =>
      $$GameSessionsTableTableTableManager(_db, _db.gameSessionsTable);
}
