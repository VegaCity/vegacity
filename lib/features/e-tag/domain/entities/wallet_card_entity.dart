import 'dart:convert';
import 'package:base/features/e-tag/domain/entities/etag_entity.dart';
import 'package:base/features/profile/domain/entities/user_entity.dart';
import 'package:base/features/profile/domain/entities/wallet_entity.dart';

class WalletCardEntity {
  final EtagEntity etag;
  // final List<WalletEntity> wallets;

  WalletCardEntity({
    required this.etag,
    // required this.wallets,
  });

  Map<String, dynamic> toMap() {
    return {
      "etag": etag.toMap(),
      // "wallets": wallets.map((wallet) => wallet.toMap()).toList(),
    };
  }

  factory WalletCardEntity.fromMap(Map<String, dynamic> map) {
    return WalletCardEntity(
      etag: EtagEntity.fromMap(map["etag"] ?? {}),
      // wallets: List<WalletEntity>.from(
      //   (map["wallets"] ?? []).map((x) => WalletEntity.fromMap(x)),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletCardEntity.fromJson(String source) =>
      WalletCardEntity.fromMap(json.decode(source));
}
