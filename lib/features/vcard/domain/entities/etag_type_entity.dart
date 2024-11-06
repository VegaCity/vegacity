import 'dart:convert';

class EtagType {
  final String id;
  final String name;
  final String marketZoneId;
  final String? imageUrl;
  final double bonusRate;
  final bool deflag;
  final int amount;
  final String walletTypeId;
  final String? marketZone;
  final String? walletType;

  EtagType({
    required this.id,
    required this.name,
    required this.marketZoneId,
    this.imageUrl,
    required this.bonusRate,
    required this.deflag,
    required this.amount,
    required this.walletTypeId,
    this.marketZone,
    this.walletType,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "marketZoneId": marketZoneId,
      "imageUrl": imageUrl,
      "bonusRate": bonusRate,
      "deflag": deflag,
      "amount": amount,
      "walletTypeId": walletTypeId,
      "marketZone": marketZone,
      "walletType": walletType,
    };
  }

  factory EtagType.fromMap(Map<String, dynamic> map) {
    return EtagType(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      marketZoneId: map["marketZoneId"] ?? '',
      imageUrl: map["imageUrl"],
      bonusRate: map["bonusRate"]?.toDouble() ?? 0.0,
      deflag: map["deflag"] ?? false,
      amount: map["amount"]?.toInt() ?? 0,
      walletTypeId: map["walletTypeId"] ?? '',
      marketZone: map["marketZone"],
      walletType: map["walletType"],
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagType.fromJson(String source) =>
      EtagType.fromMap(json.decode(source));
}
