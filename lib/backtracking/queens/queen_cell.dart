import 'package:flutter/foundation.dart';

@immutable
final class QueenCell {
  final (int, int) index;
  final bool isSelected;
  final bool cacheSelected;
  final String? color;

  const QueenCell({
    required this.index,
    required this.isSelected,
    required this.color,
    required this.cacheSelected,
  });

  factory QueenCell.create((int, int) index, [String? color]) =>
      QueenCell(index: index, isSelected: false, color: color, cacheSelected: false);

  factory QueenCell.createSelected((int, int) index, [String? color]) =>
      QueenCell(index: index, isSelected: true, color: color, cacheSelected: false);

  QueenCell markAsSelected() => QueenCell(index: index, isSelected: true, color: color, cacheSelected: cacheSelected);

  QueenCell clearSelected() => QueenCell(index: index, isSelected: false, color: color, cacheSelected: cacheSelected);

  QueenCell markAsCacheSelected() => QueenCell(index: index, isSelected: isSelected, color: color, cacheSelected: true);

  QueenCell clearCacheSelected() => QueenCell(index: index, isSelected: isSelected, color: color, cacheSelected: false);
}
