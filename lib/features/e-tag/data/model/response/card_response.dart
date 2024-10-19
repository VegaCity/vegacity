import 'dart:convert';

import 'package:base/features/e-tag/domain/entities/card_entities.dart';

class CardResponse {
  final List<CardEntities> data;

  CardResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CardResponse.fromMap(Map<String, dynamic> map) {
    return CardResponse(
      data: List<CardEntities>.from(
          map['data']?.map((x) => CardEntities.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardResponse.fromJson(String source) =>
      CardResponse.fromMap(json.decode(source));
}
