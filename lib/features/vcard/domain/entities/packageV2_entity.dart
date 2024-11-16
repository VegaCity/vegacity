import 'dart:convert';

class Package {
  final String type;

  Package({
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      type: map["type"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) => Package.fromMap(json.decode(source));
}
