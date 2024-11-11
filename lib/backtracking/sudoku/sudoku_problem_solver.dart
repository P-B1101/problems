import 'package:flutter/foundation.dart';

import '../../domain/solver_notifier.dart';
import 'sudoku_cell.dart';

class SudokuProblemSolver extends SolverNotifier<List<SudokuCell>> {
  final Map<(int, int), SudokuCell> _cells;
  final int _size;
  SudokuProblemSolver(List<List<int?>> cells)
      : _cells = _createCells(cells),
        _size = cells.length {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  static Map<(int, int), SudokuCell> _createCells(List<List<int?>> cells) {
    Map<(int, int), SudokuCell> result = {};
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        result[(j, i)] = (SudokuCell.create((j, i)));
      }
    }
    return result;
  }

  @override
  void solve() {
    if (_cells.isEmpty) return;
    _backtrack();
  }

  Future<bool> _backtrack() async {
    for (int row = 0; row < _size; row++) {
      for (int col = 0; col < _size; col++) {
        // پیدا کردن خانه خالی
        if (_cells[(row, col)]!.isValueEmpty) {
          // امتحان کردن اعداد از 1 تا 9
          for (int num = 1; num <= _size; num++) {
            if (await _isSafe(row, col, num)) {
              await notify(() => _cells[(row, col)]!.updateValue(num));
              // ادامه حل
              if (await _backtrack()) return true;
              // بازگشت
              await notify(() => _cells[(row, col)]!.clearValue());
            }
          }
          return false; // اگر هیچ عددی مناسب نبود
        }
      }
    }
    return true;
  }

  Future<bool> _isSafe(int row, int col, int num) async {
    // بررسی سطر
    for (int x = 0; x < _size; x++) {
      await notify(() => _cells[(row, x)] = _cells[(row, x)]!.updateCacheValue(num));
      if (_cells[(row, x)]!.value == num) {
        notify(() => _cells[(row, x)] = _cells[(row, x)]!.clearCacheValue());
        return false;
      }
    }

    // بررسی ستون
    for (int x = 0; x < _size; x++) {
      await notify(() => _cells[(x, col)] = _cells[(x, col)]!.updateCacheValue(num));
      if (_cells[(x, col)]!.value == num) {
        notify(() => _cells[(x, col)] = _cells[(x, col)]!.clearCacheValue());
        return false;
      }
    }

    // بررسی ناحیه 3x3
    int startRow = row - row % 3;
    int startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        await notify(() => _cells[(i + startRow, j + startCol)] = _cells[(i + startRow, j + startCol)]!.updateCacheValue(num));
        if (_cells[(i + startRow, j + startCol)]!.value == num) {
          notify(() => _cells[(i + startRow, j + startCol)]!.clearCacheValue());
          return false;
        }
      }
    }

    return true;
  }

  @override
  List<SudokuCell> get value => _cells.values.toList();
}
