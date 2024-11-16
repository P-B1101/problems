import 'package:problems/backtracking/queens/queen_cell_color.dart';

import 'queen_cell.dart';

final class ColoredQueenCell extends BaseQueenCell {
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

  ColoredQueenCell toggleColor() =>
      ColoredQueenCell(index: index, isSelected: isSelected, color: color.toggle(), cacheSelected: cacheSelected);

  @override
  ColoredQueenCell markAsSelected() =>
      ColoredQueenCell(index: index, isSelected: true, cacheSelected: cacheSelected, color: color);

  @override
  ColoredQueenCell clearSelected() =>
      ColoredQueenCell(index: index, isSelected: false, cacheSelected: cacheSelected, color: color);

  @override
  ColoredQueenCell markAsCacheSelected() =>
      ColoredQueenCell(index: index, isSelected: isSelected, cacheSelected: true, color: color);

  @override
  ColoredQueenCell clearCacheSelected() =>
      ColoredQueenCell(index: index, isSelected: isSelected, cacheSelected: false, color: color);
}
