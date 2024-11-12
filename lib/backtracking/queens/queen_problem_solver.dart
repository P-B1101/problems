import 'package:flutter/foundation.dart';

import '../../domain/solver_notifier.dart';
import 'queen_cell.dart';

class QueenProblemSolver extends SolverNotifier<(List<QueenCell> current, List<List<QueenCell>> all)> {
  @protected
  final Map<(int, int), QueenCell> cells;
  @protected
  final List<List<QueenCell>> answers;
  final int size;

  QueenProblemSolver(List<List<String?>> cells)
      : cells = _createCells(cells),
        answers = [],
        size = cells.length {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  QueenProblemSolver.fromCell(Map<(int, int), QueenCell> cellMap, int tableSize)
      : cells = cellMap,
        answers = [],
        size = tableSize {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  static Map<(int, int), QueenCell> _createCells(List<List<String?>> cells) {
    Map<(int, int), QueenCell> result = {};
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        result[(j, i)] = (QueenCell.create((j, i)));
      }
    }
    return result;
  }

  @override
  void solve() {
    if (cells.isEmpty) return;
    // List<int> queens = [];
    _solveViaBacktrack(size, 0);
  }

  Future<void> _solveViaBacktrack(int n, int row) async {
    if (row == n) {
      _constructBoard(n);
      return;
    }

    for (int col = 0; col < n; col++) {
      if (await isValid(row, col)) {
        await notify(() => cells[(row, col)] = cells[(row, col)]!.markAsSelected());
        await _solveViaBacktrack(n, row + 1);
        await notify(() => cells[(row, col)] = cells[(row, col)]!.clearSelected());
      }
    }
  }

  @protected
  Future<bool> isValid(int row, int col) async {
    for (int r = 0; r < row; r++) {
      int c = getColumn(r);
      await notify(() => cells[(row, col)] = cells[(row, col)]!.markAsCacheSelected());
      if (c == col) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if ((r - c) == (row - col)) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if ((r + c) == (row + col)) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
    }
    notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
    return true;
  }

  void _constructBoard(int n) {
    answers.add(cells.values.toList());
  }

  @override
  (List<QueenCell> current, List<List<QueenCell>> all) get value => (cells.values.toList(), answers);

  @protected
  int getColumn(int row) {
    for (int i = 0; i < size; i++) {
      if (cells[(row, i)]!.isSelected) return i;
    }
    return -1;
  }
}
