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

// class CheckGridWinnerHandler {
//   String call(List<String> grid, int size) {
//     // Горизонтали
//     for (int row = 0; row < size; row++) {
//       final first = grid[row * size];
//
//       if (first.isEmpty) continue;
//
//       var won = true;
//
//       for (int col = 1; col < size; col++) {
//         if (grid[row * size + col] != first) {
//           won = false;
//           break;
//         }
//       }
//
//       if (won) return first;
//     }
//
//     // Вертикали
//     for (int col = 0; col < size; col++) {
//       final first = grid[col];
//
//       if (first.isEmpty) continue;
//
//       var won = true;
//
//       for (int row = 1; row < size; row++) {
//         if (grid[row * size + col] != first) {
//           won = false;
//           break;
//         }
//       }
//
//       if (won) return first;
//     }
//
//     // Главная диагональ
//     final firstMain = grid[0];
//
//     if (firstMain.isNotEmpty) {
//       var won = true;
//
//       for (int i = 1; i < size; i++) {
//         if (grid[i * size + i] != firstMain) {
//           won = false;
//           break;
//         }
//       }
//
//       if (won) return firstMain;
//     }
//
//     // Побочная диагональ
//     final firstSecondary = grid[size - 1];
//
//     if (firstSecondary.isNotEmpty) {
//       var won = true;
//
//       for (int i = 1; i < size; i++) {
//         if (grid[i * size + (size - 1 - i)] != firstSecondary) {
//           won = false;
//           break;
//         }
//       }
//
//       if (won) return firstSecondary;
//     }
//
//     return '';
//   }
// }
// /// Вспомогательный метод для проверки победы в сетке из 9 ячеек (3х3)
// // String _checkGridWinner(List<String> grid) {
// //   final winPatterns = [
// //     // Горизонтали
// //     [0, 1, 2], [3, 4, 5], [6, 7, 8],
// //     // Вертикали
// //     [0, 3, 6], [1, 4, 7], [2, 5, 8],
// //     // Диагонали
// //     [0, 4, 8], [2, 4, 6],
// //   ];
// //
// //   for (final pattern in winPatterns) {
// //     final a = grid[pattern[0]];
// //     final b = grid[pattern[1]];
// //     final c = grid[pattern[2]];
// //     if (a.isNotEmpty && a == b && a == c) {
// //       return a;
// //     }
// //   }
// //   return '';
// // }
