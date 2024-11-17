import 'queen_cell.dart';

abstract interface class QueenCellMarker<T extends BaseQueenCell> {
  T markAsSelected();

  T clearSelected();

  T markAsCacheSelected();

  T clearCacheSelected();

}
