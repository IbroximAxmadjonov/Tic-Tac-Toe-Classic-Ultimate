class CheckGridWinnerHandler {
  String call({
    required List<String> grid,
    required int size,
    required int winLength,
  }) {
    if (winLength < 1 || winLength > size) {
      return '';
    }

    // Проверяем горизонтали.
    for (int row = 0; row < size; row++) {
      for (int col = 0; col <= size - winLength; col++) {
        final first = grid[row * size + col];

        if (first.isEmpty) continue;

        var won = true;

        for (int i = 1; i < winLength; i++) {
          if (grid[row * size + col + i] != first) {
            won = false;
            break;
          }
        }

        if (won) return first;
      }
    }

    // Проверяем вертикали.
    for (int col = 0; col < size; col++) {
      for (int row = 0; row <= size - winLength; row++) {
        final first = grid[row * size + col];

        if (first.isEmpty) continue;

        var won = true;

        for (int i = 1; i < winLength; i++) {
          if (grid[(row + i) * size + col] != first) {
            won = false;
            break;
          }
        }

        if (won) return first;
      }
    }

    // Проверяем главные диагонали.
    for (int row = 0; row <= size - winLength; row++) {
      for (int col = 0; col <= size - winLength; col++) {
        final first = grid[row * size + col];

        if (first.isEmpty) continue;

        var won = true;

        for (int i = 1; i < winLength; i++) {
          if (grid[(row + i) * size + col + i] != first) {
            won = false;
            break;
          }
        }

        if (won) return first;
      }
    }

    // Проверяем побочные диагонали.
    for (int row = 0; row <= size - winLength; row++) {
      for (int col = winLength - 1; col < size; col++) {
        final first = grid[row * size + col];

        if (first.isEmpty) continue;

        var won = true;

        for (int i = 1; i < winLength; i++) {
          if (grid[(row + i) * size + col - i] != first) {
            won = false;
            break;
          }
        }

        if (won) return first;
      }
    }

    return '';
  }
}
