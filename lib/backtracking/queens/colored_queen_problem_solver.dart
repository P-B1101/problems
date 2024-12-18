import 'colored_queen_cell.dart';
import 'queen_cell_color.dart';
import 'queen_problem_solver.dart';

class ColoredQueenProblemSolver extends BaseQueenProblemSolver<ColoredQueenCell> {
  ColoredQueenProblemSolver(List<List<QueenCellColor>> cells) : super.fromCell(_createCells(cells), cells.length);

  static Map<(int, int), ColoredQueenCell> _createCells(List<List<QueenCellColor>> cells) {
    Map<(int, int), ColoredQueenCell> result = {};
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        result[(j, i)] = (ColoredQueenCell.create((j, i), cells[i][j]));
      }
    }
    return result;
  }

  @override
  Future<bool> isValid(int row, int col) async {
    for (int r = 0; r < row; r++) {
      int c = getColumn(r);
      await notify(() => cells[(row, col)] = cells[(row, col)]!.markAsCacheSelected());
      if (c == col) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if ((row - r).abs() == 1 && (c - col).abs() == 1) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
      if (cells[(row, col)]!.color == cells[(r, c)]!.color) {
        notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
        return false;
      }
    }
    notify(() => cells[(row, col)] = cells[(row, col)]!.clearCacheSelected());
    return true;
  }

  @override
  (List<ColoredQueenCell> current, List<List<ColoredQueenCell>> all, bool isCalculating) get value =>
      (cells.values.toList(), answers, isCalculating);

  @override
  void updateCell(ColoredQueenCell cell) {
    cells[cell.index] = cells[cell.index]!.toggleColor();
    super.updateCell(cell);
  }
}
