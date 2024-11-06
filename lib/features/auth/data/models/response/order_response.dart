import 'dart:convert';

import 'package:base/features/auth/domain/entities/order_entities.dart';

class OrderResponse {
  final OrderEntities data;

  OrderResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data});

    return result;
  }

  factory OrderResponse.fromMap(Map<String, dynamic> map) {
    return OrderResponse(
      data: OrderEntities.fromMap(map["data"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromJson(String source) =>
      OrderResponse.fromMap(json.decode(source));
}
