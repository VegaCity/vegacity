import 'dart:convert';

import 'package:base/features/profile/domain/entities/wallet_entity.dart';



class WalletResponse {
  final WalletEntity data;

  WalletResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data});

    return result;
  }

  factory WalletResponse.fromMap(Map<String, dynamic> map) {
    return WalletResponse(
      data: WalletEntity.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletResponse.fromJson(String source) =>
      WalletResponse.fromMap(json.decode(source));
}
