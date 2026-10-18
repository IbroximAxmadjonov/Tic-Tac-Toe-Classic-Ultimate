import 'package:tic_tac_toe/core/domain/constants/enums.dart';

class GameStateEntity {
  final PlayerSymbol currentPlayer;
  final GameMode gameMode;
  final GameStatus gameStatus;
  final int moveCount;
  final List<Permission> permissibleBigGrid;
  final bool firstMove;

  GameStateEntity({
    this.currentPlayer = PlayerSymbol.x,
    required this.gameMode,
    this.gameStatus = GameStatus.playing,
    this.moveCount = 0,
    required this.permissibleBigGrid,
    this.firstMove = true,
  });

  GameStateEntity copyWith({
    PlayerSymbol? currentPlayer,
    GameMode? gameMode,
    GameStatus? gameStatus,
    int? moveCount,
    List<Permission>? permissibleBigGrid,
    bool? firstMove,
  }) {
    return GameStateEntity(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      gameMode: gameMode ?? this.gameMode,
      gameStatus: gameStatus ?? this.gameStatus,
      moveCount: moveCount ?? this.moveCount,
      permissibleBigGrid: permissibleBigGrid ?? this.permissibleBigGrid,
      firstMove: firstMove ?? this.firstMove,
    );
  }
}
