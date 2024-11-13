import 'dart:convert';
import 'package:base/features/promotion/domain/entities/promotion_entities.dart';

class PromotionResponse {
  final List<PromotionEntities> data;

  PromotionResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PromotionResponse.fromMap(Map<String, dynamic> map) {
    return PromotionResponse(
      data: List<PromotionEntities>.from(
          map['data']?.map((x) => PromotionEntities.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionResponse.fromJson(String source) =>
      PromotionResponse.fromMap(json.decode(source));
}
