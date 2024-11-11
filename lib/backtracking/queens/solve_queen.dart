import 'package:flutter/foundation.dart';
import 'package:problems/backtracking/queens/queen_cell.dart';

final class QueenProblemSolver extends ChangeNotifier
    implements ValueListenable<(List<QueenCell> current, List<List<QueenCell>> all)> {
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
        _cells[(queens.length - 1, col)] = _cells[(queens.length - 1, col)]!.markAsSelected();
        await _notify();
        await _backtrack(n, row + 1, queens);
        _cells[(queens.length - 1, queens.last)] = _cells[(queens.length - 1, queens.last)]!.clearSelected();
        await _notify();
        queens.removeLast();
      }
    }
  }

  Future<bool> _isValid(List<int> queens, int row, int col) async {
    for (int r = 0; r < row; r++) {
      int c = queens[r];
      _cells[(row, col)] = _cells[(row, col)]!.markAsCacheSelected();
      await _notify();
      if (c == col) {
        _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected();
        _notify();
        return false;
      }
      if ((r - c) == (row - col)) {
        _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected();
        _notify();
        return false;
      }
      if ((r + c) == (row + col)) {
        _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected();
        _notify();
        return false;
      }
    }
    _cells[(row, col)] = _cells[(row, col)]!.clearCacheSelected();
    _notify();
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

  Future<void> _notify() async {
    notifyListeners();
    await Future.delayed(Duration.zero);
  }

  @override
  (List<QueenCell> current, List<List<QueenCell>> all) get value => (_cells.values.toList(), _answers);
}
