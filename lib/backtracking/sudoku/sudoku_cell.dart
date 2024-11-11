import 'package:flutter/foundation.dart';

@immutable
final class SudokuCell {
  final (int, int) index;
  final int? value;
  final int? cacheValue;

  const SudokuCell({
    required this.index,
    required this.value,
    required this.cacheValue,
  });

  factory SudokuCell.create((int, int) index) => SudokuCell(index: index, value: null, cacheValue: null);

  factory SudokuCell.createSelected((int, int) index, [String? color]) => SudokuCell(index: index, value: null, cacheValue: null);

  SudokuCell updateValue(int value) => SudokuCell(index: index, value: value, cacheValue: cacheValue);

  SudokuCell clearValue() => SudokuCell(index: index, value: null, cacheValue: cacheValue);

  SudokuCell updateCacheValue(int cacheValue) => SudokuCell(index: index, value: value, cacheValue: cacheValue);

  SudokuCell clearCacheValue() => SudokuCell(index: index, value: value, cacheValue: null);

  bool get isValueEmpty => value == null;

  bool get isCacheEmpty => cacheValue == null;

  bool get isEmpty => isValueEmpty && isCacheEmpty;
}
