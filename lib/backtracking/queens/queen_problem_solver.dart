import 'package:flutter/foundation.dart';

import '../../domain/solver_notifier.dart';
import 'queen_cell.dart';

final class QueenProblemSolver extends SolverNotifier<(List<QueenCell> current, List<List<QueenCell>> all)> {
  final Map<(int, int), QueenCell> _cells;
  final List<List<QueenCell>> _answers;
  final int size;

  QueenProblemSolver(List<List<String?>> cells)
      : _cells = _createCells(cells),
        _answers = [],
        size = cells.length {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  static Map<(int, int), QueenCell> _createCells(List<List<String?>> cells) {
    Map<(int, int), QueenCell> result = {};
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        result[(j, i)] = (QueenCell.create((j, i), '$j, $i'));
      }
    }
    return result;
  }

  @override
  void solve() {
    if (_cells.isEmpty) return;
    List<int> queens = [];
    _backtrack(size, 0, queens);
  }

  Future<void> _backtrack(int n, int row, List<int> queens) async {
    if (row == n) {
      _constructBoard(queens, n);
      return;
    }

    for (int col = 0; col < n; col++) {
      if (await _isValid(queens, row, col)) {
        queens.add(col);
        await notify(() => _cells[(queens.length - 1, col)] = _cells[(queens.length - 1, col)]!.markAsSelected());
        await _backtrack(n, row + 1, queens);
        await notify(() => _cells[(queens.length - 1, queens.last)] = _cells[(queens.length - 1, queens.last)]!.clearSelected());
        queens.removeLast();
      }
    }
  }

  Future<bool> _isValid(List<int> queens, int row, int col) async {
    for (int r = 0; r < row; r++) {
      int c = queens[r];
      await notify(() => _cells[(row, col)] = _cells[(row, col)]!.markAsCacheSelected());
      if (c == col) {
        notify(() => _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if ((r - c) == (row - col)) {
        notify(() => _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if ((r + c) == (row + col)) {
        notify(() => _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected());
        return false;
      }
    }
    notify(() => _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected());
    return true;
  }

  void _constructBoard(List<int> queens, int n) {
    List<QueenCell> board = [];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (queens[i] == j) {
          board.add(QueenCell.createSelected((i, j)));
        } else {
          board.add(QueenCell.create((i, j)));
        }
      }
    }
    _answers.add(board);
  }

  @override
  (List<QueenCell> current, List<List<QueenCell>> all) get value => (_cells.values.toList(), _answers);
}
