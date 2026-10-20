enum PlayerSymbol { x, o }

// пока не обдумал использование GameStatus и его параметров
enum GameStatus { playing, won, draw }

enum GameMode { classic, ultimate, expanded, threeInARow }

enum SaveGame { yes, no }

enum Permission { permissible, notPermissible }

/// The result is relative to the canonical pair order:
/// player1Id < player2Id.
/// `player1Won` means the lower-ID player won.
enum GameResult { player1Won, player2Won, draw }
