import 'cell_model.dart';

class CellsGrid {
  final List<List<Cell>> _fieldMatrix;

  CellsGrid({required List<List<Cell>> fieldMatrix})
      : _fieldMatrix = fieldMatrix;

  Cell operator [](({int x, int y}) position) =>
      _fieldMatrix[position.y][position.x];

  int get size => _fieldMatrix.length;

  List<Cell> get asFlatList {
    List<Cell> result = [];
    for (var row in _fieldMatrix) {
      result.addAll(row);
    }
    return result;
  }
}
