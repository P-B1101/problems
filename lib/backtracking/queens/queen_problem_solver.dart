import 'package:flutter/foundation.dart';

import '../../domain/solver_notifier.dart';
import 'queen_cell.dart';

abstract class BaseQueenProblemSolver<T extends BaseQueenCell>
    extends SolverNotifier<(List<BaseQueenCell> current, List<List<BaseQueenCell>> all)> {
  @protected
  late final Map<(int, int), T> cells;
  @protected
  final List<List<T>> answers;
  final int size;

  BaseQueenProblemSolver.fromCell(Map<(int, int), T> cellMap, int tableSize)
      : cells = cellMap,
        answers = [],
        size = tableSize {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  @override
  void solve() {
    if (cells.isEmpty) return;
    solveViaBacktrack(size, 0);
  }

  int getColumn(int row) {
    for (int i = 0; i < size; i++) {
      if (cells[(row, i)]!.isSelected) return i;
    }
    return -1;
  }

  Future<void> solveViaBacktrack(int n, int row) async {
    if (row == n) {
      _constructBoard(n);
      return;
    }
    for (int col = 0; col < n; col++) {
      if (await isValid(row, col)) {
        await notify(() => cells[(row, col)] = cells[(row, col)]!.markAsSelected() as T);
        await solveViaBacktrack(n, row + 1);
        await notify(() => cells[(row, col)] = cells[(row, col)]!.clearSelected() as T);
      }
    }
  }

  Future<bool> isValid(int row, int col) async {
    for (int r = 0; r < row; r++) {
      int c = getColumn(r);
      await notify(() => cells[(row, col)] = cells[(row, col)]!.markAsCacheSelected() as T);
      if (c == col) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected() as T);
        return false;
      }
      if ((r - c) == (row - col)) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected() as T);
        return false;
      }
      if ((r + c) == (row + col)) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected() as T);
        return false;
      }
    }
    notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected() as T);
    return true;
  }

  void _constructBoard(int n) {
    answers.add(cells.values.toList());
  }
}

class QueenProblemSolver extends BaseQueenProblemSolver<QueenCell> {
  QueenProblemSolver(List<List> cells) : super.fromCell(_createCells(cells), cells.length);

  static Map<(int, int), QueenCell> _createCells(List<List> cells) {
    Map<(int, int), QueenCell> result = {};
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        result[(j, i)] = QueenCell.create((j, i));
      }
    }
    return result;
  }

  @override
  (List<QueenCell> current, List<List<QueenCell>> all) get value => (cells.values.toList(), answers);
}
