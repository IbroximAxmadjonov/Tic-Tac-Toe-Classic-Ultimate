import '../constants/enums.dart';

class GameStateEntity {
  final PlayerSymbol currentSymbol;
  final GameMode gameMode;
  final GameStatus gameStatus;
  final int moveCount;
  final List<Permission> permissibleBigGrid;
  final SaveGame saveGame;

  GameStateEntity({
    this.currentSymbol = PlayerSymbol.x,
    required this.gameMode,
    this.gameStatus = GameStatus.playing,
    this.moveCount = 0,
    required this.permissibleBigGrid,
    required this.saveGame,
  });

  GameStateEntity copyWith({
    PlayerSymbol? currentSymbol,
    GameMode? gameMode,
    GameStatus? gameStatus,
    int? moveCount,
    List<Permission>? permissibleBigGrid,
    SaveGame? saveGame,
  }) {
    return GameStateEntity(
      currentSymbol: currentSymbol ?? this.currentSymbol,
      gameMode: gameMode ?? this.gameMode,
      gameStatus: gameStatus ?? this.gameStatus,
      moveCount: moveCount ?? this.moveCount,
      permissibleBigGrid: permissibleBigGrid ?? this.permissibleBigGrid,
      saveGame: saveGame ?? this.saveGame,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentSymbol': currentSymbol.name,
      'gameMode': gameMode.name,
      'gameStatus': gameStatus.name,
      'moveCount': moveCount,
      'permissibleBigGrid': permissibleBigGrid,
      'saveGame': saveGame.name,
    };
  }

  factory GameStateEntity.fromJson(Map<String, dynamic> map) {
    return GameStateEntity(
      currentSymbol: PlayerSymbol.values.firstWhere(
        (symbol) => symbol.name == map['currentSymbol'],
      ),
      gameMode: GameMode.values.firstWhere((mode) => mode.name == map['gameMode']),
      gameStatus: GameStatus.values.firstWhere(
        (status) => status.name == map['gameStatus'],
      ),
      moveCount: map['moveCount'] as int,
      permissibleBigGrid: List<Permission>.from(
        map['permissibleBigGrid'] as List<dynamic>,
      ),
      saveGame: SaveGame.values.firstWhere(
        (save) => save.name == map['saveGame'],
      ),
    );
  }
}
