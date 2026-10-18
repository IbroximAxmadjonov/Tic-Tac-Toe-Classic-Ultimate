class GameGridItemsEntity {
  final List<String> bigGridItems;
  final int bigGridCrossAxisCount;

  final List<List<String>> smallGridItems;
  final int smallGridCrossAxisCount;

  GameGridItemsEntity({
    required this.bigGridItems,
    required this.bigGridCrossAxisCount,
    required this.smallGridItems,
    required this.smallGridCrossAxisCount,
  });

  GameGridItemsEntity copyWith({
    List<String>? bigGridItems,
    int? bigGridCrossAxisCount,
    List<List<String>>? smallGridItems,
    int? smallGridCrossAxisCount,
  }) {
    return GameGridItemsEntity(
      // Создаем копию первого уровня
      bigGridItems: bigGridItems != null
          ? List<String>.from(bigGridItems)
          : this.bigGridItems,
      bigGridCrossAxisCount: bigGridCrossAxisCount ?? this.bigGridCrossAxisCount,

      // ГЛУБОКАЯ КОПИЯ: клонируем внешний список и каждый вложенный список
      smallGridItems: smallGridItems != null
          ? smallGridItems.map((list) => List<String>.from(list)).toList()
          : this.smallGridItems,
      smallGridCrossAxisCount:
      smallGridCrossAxisCount ?? this.smallGridCrossAxisCount,
    );
  }
}
