import 'position_model.dart';

enum CellType { normal, blocked, start, end, path }

class Cell {
  final Position position;
  CellType type;

  Cell({required this.position, required this.type});

  bool get isWalkable => type != CellType.blocked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          runtimeType == other.runtimeType &&
          position.x == other.position.x &&
          position.y == other.position.y;

  @override
  int get hashCode => position.x.hashCode ^ position.y.hashCode;

  @override
  String toString() => position.toString();
}
