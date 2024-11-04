import 'dart:convert';

class Position {
  final int x;
  final int y;

  Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => '($x, $y)';
}
