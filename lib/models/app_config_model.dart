import 'position_model.dart';

class AppConfigModel {
  final String id;
  final List<String> field;
  final Position start;
  final Position end;

  AppConfigModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      id: json['id'] as String,
      field: List<String>.from(json['field']),
      start: Position.fromJson(json['start']),
      end: Position.fromJson(json['end']),
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
