import 'dart:convert';


class Role {
  final String id;
  final String name;
  final bool deflag;

  Role({
    required this.id,
    required this.name,
    required this.deflag,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "deflag": deflag,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      deflag: map["deflag"] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));
}
