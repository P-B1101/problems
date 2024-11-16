import 'package:flutter/foundation.dart';
import 'package:problems/backtracking/queens/queen_cell_marker.dart';

@immutable
abstract base class BaseQueenCell implements QueenCellMarker<BaseQueenCell> {
  final (int, int) index;
  final bool isSelected;
  final bool cacheSelected;

  const BaseQueenCell({
    required this.index,
    required this.isSelected,
    required this.cacheSelected,
  });
}

final class QueenCell extends BaseQueenCell {
  const QueenCell({
    required super.index,
    required super.isSelected,
    required super.cacheSelected,
  });

  factory QueenCell.create((int, int) index) => QueenCell(index: index, isSelected: false, cacheSelected: false);

  factory QueenCell.createSelected((int, int) index) => QueenCell(index: index, isSelected: true, cacheSelected: false);

  @override
  QueenCell markAsSelected() => QueenCell(index: index, isSelected: true, cacheSelected: cacheSelected);

  @override
  QueenCell clearSelected() => QueenCell(index: index, isSelected: false, cacheSelected: cacheSelected);

  @override
  QueenCell markAsCacheSelected() => QueenCell(index: index, isSelected: isSelected, cacheSelected: true);

  @override
  QueenCell clearCacheSelected() => QueenCell(index: index, isSelected: isSelected, cacheSelected: false);
}
