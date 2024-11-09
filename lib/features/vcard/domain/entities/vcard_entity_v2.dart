import 'dart:convert';

class VcardEntitiesV2 {
  final String id;

  VcardEntitiesV2({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }   


  factory VcardEntitiesV2.fromMap(Map<String, dynamic> map) {
    return VcardEntitiesV2(
      id: map['id'] ?? '',
    );
  }

   String toJson() => json.encode(toMap());

  factory VcardEntitiesV2.fromJson(String source) =>
      VcardEntitiesV2.fromMap(json.decode(source));
}
