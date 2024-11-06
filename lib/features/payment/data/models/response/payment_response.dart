import 'dart:convert';

import 'package:base/features/payment/domain/entities/payment_entity/payment_entity.dart';

class PaymentResponse {
  final PaymentEntity data;

  PaymentResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory PaymentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentResponse(
      data: PaymentEntity.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentResponse.fromJson(String source) =>
      PaymentResponse.fromMap(json.decode(source));
}
