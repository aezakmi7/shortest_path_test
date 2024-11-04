import 'dart:collection';

import '../models/app_config_model.dart';
import '../models/calculating_result_model.dart';
import '../models/cell_model.dart';
import '../models/grid_model.dart';
import '../models/position_model.dart';

abstract interface class IAppProcessorService {
  List<CalculatingResultModel> findShortestPath(
      List<AppConfigModel> appConfigs);
}

class AppProcessorService implements IAppProcessorService {
  @override
  List<CalculatingResultModel> findShortestPath(
      List<AppConfigModel> appConfigs) {
    return [for (var ac in appConfigs) _findShortestPath(ac)];
  }

  CalculatingResultModel _findShortestPath(AppConfigModel appConfig) {
    final cellMatrix =
        _initMatrix(appConfig.field, appConfig.start, appConfig.end);
    final startingCell = cellMatrix[appConfig.start.y][appConfig.start.x];
    final endingCell = cellMatrix[appConfig.end.y][appConfig.end.x];

    var shortestPath = _getShortestPath(cellMatrix, startingCell, endingCell)!;

    // update path sell type
    for (var updatedCell in shortestPath) {
      cellMatrix[updatedCell.position.y][updatedCell.position.x].type =
          updatedCell.type;
    }

    return CalculatingResultModel(
      id: appConfig.id,
      result: Result(
        steps:
            shortestPath.map((cell) => cell.position).toList(growable: false),
        path: shortestPath.join('->'),
      ),
      finalCellsGrid: CellsGrid(fieldMatrix: cellMatrix),
    );
  }

  List<List<Cell>> _initMatrix(
      List<String> rawField, Position start, Position end) {
    final size = rawField.length;

    List<List<Cell>> resultMatrix = List.generate(size, (y) {
      return List.generate(size, (x) {
        var cellType =
            rawField[y][x] == 'X' ? CellType.blocked : CellType.normal;
        return Cell(position: Position(x: x, y: y), type: cellType);
      });
    });

    resultMatrix[start.y][start.x].type = CellType.start;
    resultMatrix[end.y][end.x].type = CellType.end;

    return resultMatrix;
  }

  bool _isValidPosition(Position position, int rangeLimit) {
    return position.x >= 0 &&
        position.x < rangeLimit &&
        position.y >= 0 &&
        position.y < rangeLimit;
  }

  bool _isValidCell(Cell cell, int matrixSize) {
    return cell.isWalkable && _isValidPosition(cell.position, matrixSize);
  }

  List<Position> _getPotentialNeighborsPosition(Position cellPosition) {
    const linearDeltas = [-1, 0, 1];
    final neighborDeltas = [
      for (var dx in linearDeltas)
        for (var dy in linearDeltas)
          // excluding current cell from neighbors
          if (dx != 0 || dy != 0) (dx: dx, dy: dy)
    ];

    return [
      for (var nd in neighborDeltas)
        Position(x: cellPosition.x + nd.dx, y: cellPosition.y + nd.dy)
    ];
  }

  List<Cell> _getNeighborCells(Cell cell, List<List<Cell>> matrix) {
    final potentialNeighborPosition =
        _getPotentialNeighborsPosition(cell.position);

    return [
      for (final pnc in potentialNeighborPosition)
        if (_isValidPosition(pnc, matrix.length) &&
            matrix[pnc.y][pnc.x].isWalkable)
          matrix[pnc.y][pnc.x]
    ];
  }

  List<Cell>? _getShortestPath(List<List<Cell>> matrix, Cell start, Cell end) {
    if (!_isValidCell(start, matrix.length) &&
        !_isValidCell(end, matrix.length)) return null;

    Queue<List<Cell>> queue = Queue();
    Set<Cell> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      var path = queue.removeFirst();
      var current = path.last;

      if (current == end) {
        final pathRange = (firstStepIndex: 1, lastStepIndex: path.length - 2);
        for (var i = pathRange.firstStepIndex;
            i <= pathRange.lastStepIndex;
            i++) {
          path[i].type = CellType.path;
        }
        return path;
      }

      for (var neighbor in _getNeighborCells(current, matrix)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          var updatedPath = List<Cell>.from(path)..add(neighbor);
          queue.add(updatedPath);
        }
      }
    }

    return null;
  }
}
