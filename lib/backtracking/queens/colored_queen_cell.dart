import 'package:problems/backtracking/queens/queen_cell_color.dart';

import 'queen_cell.dart';

final class ColoredQueenCell extends QueenCell {
  final QueenCellColor color;

  const ColoredQueenCell({
    required super.index,
    required super.isSelected,
    required super.cacheSelected,
    required this.color,
  });

  factory ColoredQueenCell.create((int, int) index, QueenCellColor color) =>
      ColoredQueenCell(index: index, isSelected: false, color: color, cacheSelected: false);

  factory ColoredQueenCell.createSelected((int, int) index, QueenCellColor color) =>
      ColoredQueenCell(index: index, isSelected: true, color: color, cacheSelected: false);

  ColoredQueenCell toggleColor() => ColoredQueenCell(index: index, isSelected: isSelected, color: color.toggle(), cacheSelected: cacheSelected);
}
