import 'dart:convert';

import 'package:base/features/profile/domain/entities/wallet_entity.dart';

class WalletResponse {
  final List<WalletEntity> data;

  WalletResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'data': data.map((x) => x.toMap()).toList()});
    return result;
  }

  factory WalletResponse.fromMap(Map<String, dynamic> map) {
    return WalletResponse(
      data: List<WalletEntity>.from(
          map['data']?.map((x) => WalletEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletResponse.fromJson(String source) =>
      WalletResponse.fromMap(json.decode(source));
}
