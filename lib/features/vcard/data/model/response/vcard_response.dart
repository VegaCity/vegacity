import 'dart:convert';
import 'package:base/features/vcard/domain/entities/vcard_entity.dart';

class VcardResponse {
  final VcardEntities data;

  VcardResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory VcardResponse.fromMap(Map<String, dynamic> map) {
    return VcardResponse(
      data: VcardEntities.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VcardResponse.fromJson(String source) =>
      VcardResponse.fromMap(json.decode(source));
}
