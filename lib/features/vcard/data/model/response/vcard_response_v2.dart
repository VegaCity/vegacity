import 'dart:convert';
import 'package:base/features/vcard/domain/entities/vcard_entity_v2.dart';

class VcardResponseV2 {
  final VcardEntitiesV2 data;

  VcardResponseV2({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory VcardResponseV2.fromMap(Map<String, dynamic> map) {
    return VcardResponseV2(
      data: VcardEntitiesV2.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VcardResponseV2.fromJson(String source) =>
      VcardResponseV2.fromMap(json.decode(source));
}
