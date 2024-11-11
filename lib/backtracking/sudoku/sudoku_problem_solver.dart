class SudokuSolver {
  static const int SIZE = 9;

  bool _isSafe(List<List<int>> grid, int row, int col, int num) {
    // بررسی سطر
    for (int x = 0; x < SIZE; x++) {
      if (grid[row][x] == num) {
        return false;
      }
    }

    // بررسی ستون
    for (int x = 0; x < SIZE; x++) {
      if (grid[x][col] == num) {
        return false;
      }
    }

    // بررسی ناحیه 3x3
    int startRow = row - row % 3;
    int startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i + startRow][j + startCol] == num) {
          return false;
        }
      }
    }

    return true;
  }

  bool solve(List<List<int>> grid) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        // پیدا کردن خانه خالی
        if (grid[row][col] == 0) {
          // امتحان کردن اعداد از 1 تا 9
          for (int num = 1; num <= SIZE; num++) {
            if (_isSafe(grid, row, col, num)) {
              grid[row][col] = num;

              // ادامه حل
              if (solve(grid)) {
                return true;
              }

              // بازگشت
              grid[row][col] = 0;
            }
          }
          return false; // اگر هیچ عددی مناسب نبود
        }
      }
    }
    return true; // اگر جدول کامل شده باشد
  }

  void _printGrid(List<List<int>> grid) {
    for (var row in grid) {
      print(row);
    }
  }
}