import 'package:flutter/foundation.dart';

@immutable
base class QueenCell {
  final (int, int) index;
  final bool isSelected;
  final bool cacheSelected;

  const QueenCell({
    required this.index,
    required this.isSelected,
    required this.cacheSelected,
  });

  factory QueenCell.create((int, int) index) => QueenCell(index: index, isSelected: false, cacheSelected: false);

  factory QueenCell.createSelected((int, int) index) => QueenCell(index: index, isSelected: true, cacheSelected: false);

  QueenCell markAsSelected() => QueenCell(index: index, isSelected: true, cacheSelected: cacheSelected);

  QueenCell clearSelected() => QueenCell(index: index, isSelected: false, cacheSelected: cacheSelected);

  QueenCell markAsCacheSelected() => QueenCell(index: index, isSelected: isSelected, cacheSelected: true);

  QueenCell clearCacheSelected() => QueenCell(index: index, isSelected: isSelected, cacheSelected: false);
}
