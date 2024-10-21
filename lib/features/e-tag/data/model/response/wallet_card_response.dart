import 'dart:convert';

import 'package:base/features/e-tag/domain/entities/wallet_card_entity.dart';


class WalletCardResponse {
  final WalletCardEntity data;

  WalletCardResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.toMap()});

    return result;
  }

  factory WalletCardResponse.fromMap(Map<String, dynamic> map) {
    return WalletCardResponse(
      data: WalletCardEntity.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletCardResponse.fromJson(String source) =>
      WalletCardResponse.fromMap(json.decode(source));
}
