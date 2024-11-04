import 'dart:convert';

import 'position_model.dart';
import 'grid_model.dart';

class CalculatingResultModel {
  final String id;
  final Result result;
  final CellsGrid finalCellsGrid;

  CalculatingResultModel({
    required this.id,
    required this.result,
    required this.finalCellsGrid,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "result": result.toJson(),
      };
}

class Result {
  final List<Position> steps;
  final String path;

  Result({
    required this.steps,
    required this.path,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "path": path,
      };
}
