import 'dart:convert';

class VcardRequest {
  final String? id;

  VcardRequest({this.id});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
    };
  }

  factory VcardRequest.fromMap(Map<String, dynamic> map) {
    return VcardRequest(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VcardRequest.fromJson(String source) =>
      VcardRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VcardRequest(id: $id)';
  }
}
