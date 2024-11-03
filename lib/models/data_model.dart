class DataModel {
  final String id;
  final List<String> field;
  final CoordinatesModel start;
  final CoordinatesModel end;
  DataModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] as String,
      field: json['field'] as List<String>,
      start: CoordinatesModel.fromJson(json['start']),
      end: CoordinatesModel.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

class CoordinatesModel {
  final int x;
  final int y;
  CoordinatesModel({
    required this.x,
    required this.y,
  });
  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
