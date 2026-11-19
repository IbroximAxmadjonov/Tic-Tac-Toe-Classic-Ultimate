import '../constants/enums.dart';

class GridItemsEntity {
  final List<String> bigGridItems;
  final int bigGridCrossAxisCount;
  final int bigGridWinLength;

  final List<List<String>> smallGridItems;
  final int smallGridCrossAxisCount;
  final int smallGridWinLength;

  GridItemsEntity({
    required this.bigGridItems,
    required this.bigGridCrossAxisCount,
    required this.bigGridWinLength,
    required this.smallGridItems,
    required this.smallGridCrossAxisCount,
    required this.smallGridWinLength,
  });

  factory GridItemsEntity.classic() {
    return GridItemsEntity(
      bigGridItems: List.filled(1, ''),
      bigGridCrossAxisCount: 1,
      bigGridWinLength: 1,
      smallGridItems: [List.filled(9, '')],
      smallGridCrossAxisCount: 3,
      smallGridWinLength: 3,
    );
  }

  factory GridItemsEntity.ultimate() {
    return GridItemsEntity(
      bigGridItems: List.filled(9, ''),
      bigGridCrossAxisCount: 3,
      bigGridWinLength: 3,
      smallGridItems: List.filled(9, List.filled(9, '')),
      smallGridCrossAxisCount: 3,
      smallGridWinLength: 3,
    );
  }

  factory GridItemsEntity.expanded(int size) {
    return GridItemsEntity(
      bigGridItems: List.filled(1, ''),
      bigGridCrossAxisCount: 1,
      bigGridWinLength: 1,
      smallGridItems: [List.filled(size * size, '')],
      smallGridCrossAxisCount: size,
      smallGridWinLength: size,
    );
  }

  factory GridItemsEntity.threeInARow(int size) {
    return GridItemsEntity(
      bigGridItems: List.filled(1, ''),
      bigGridCrossAxisCount: 1,
      bigGridWinLength: 1,
      smallGridItems: [List.filled(size * size, '')],
      smallGridCrossAxisCount: size,
      smallGridWinLength: 3,
    );
  }

  factory GridItemsEntity.byMode({required GameMode mode, required int size}) {
    return switch (mode) {
      GameMode.classic => GridItemsEntity.classic(),
      GameMode.ultimate => GridItemsEntity.ultimate(),
      GameMode.expanded => GridItemsEntity.expanded(size),
      GameMode.threeInARow => GridItemsEntity.threeInARow(size),
    };
  }

  GridItemsEntity copyWith({
    List<String>? bigGridItems,
    int? bigGridCrossAxisCount,
    int? bigGridWinLength,
    List<List<String>>? smallGridItems,
    int? smallGridCrossAxisCount,
    int? smallGridWinLength,
  }) {
    return GridItemsEntity(
      // Создаем копию первого уровня
      bigGridItems: bigGridItems != null
          ? List<String>.from(bigGridItems)
          : this.bigGridItems,
      bigGridCrossAxisCount: bigGridCrossAxisCount ?? this.bigGridCrossAxisCount,
      bigGridWinLength: bigGridWinLength ?? this.bigGridWinLength,

      // ГЛУБОКАЯ КОПИЯ: клонируем внешний список и каждый вложенный список
      smallGridItems: smallGridItems != null
          ? smallGridItems.map((list) => List<String>.from(list)).toList()
          : this.smallGridItems,
      smallGridCrossAxisCount:
          smallGridCrossAxisCount ?? this.smallGridCrossAxisCount,
      smallGridWinLength: smallGridWinLength ?? this.smallGridWinLength,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bigGridItems': bigGridItems,
      'bigGridCrossAxisCount': bigGridCrossAxisCount,
      'bigGridWinLength': bigGridWinLength,
      'smallGridItems': smallGridItems,
      'smallGridCrossAxisCount': smallGridCrossAxisCount,
      'smallGridWinLength': smallGridWinLength,
    };
  }

  factory GridItemsEntity.fromJson(Map<String, dynamic> map) {
    return GridItemsEntity(
      bigGridItems: map['bigGridItems'] as List<String>,
      bigGridCrossAxisCount: map['bigGridCrossAxisCount'] as int,
      bigGridWinLength: map['bigGridWinLength'] as int,
      smallGridItems: map['smallGridItems'] as List<List<String>>,
      smallGridCrossAxisCount: map['smallGridCrossAxisCount'] as int,
      smallGridWinLength: map['smallGridWinLength'] as int,
    );
  }
}
