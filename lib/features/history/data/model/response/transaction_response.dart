import 'dart:convert';

import 'package:base/features/history/domain/entities/transaction_entity.dart';

class TransactionResponse {
  final List<TransactionEntity> data;

  TransactionResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'data': data.map((x) => x.toMap()).toList()});
    return result;
  }

  factory TransactionResponse.fromMap(Map<String, dynamic> map) {
    return TransactionResponse(
      data: List<TransactionEntity>.from(
          map['data']?.map((x) => TransactionEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionResponse.fromJson(String source) =>
      TransactionResponse.fromMap(json.decode(source));
}
