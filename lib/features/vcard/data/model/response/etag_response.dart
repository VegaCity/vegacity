import 'dart:convert';
import 'package:base/features/vcard/domain/entities/etag_entity.dart';

class EtagResponse {
  final EtagParentEntity data;

  EtagResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory EtagResponse.fromMap(Map<String, dynamic> map) {
    return EtagResponse(
      data: EtagParentEntity.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagResponse.fromJson(String source) =>
      EtagResponse.fromMap(json.decode(source));
}
