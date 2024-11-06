import 'dart:convert';

class WalletEntity {
  final String id;
  final String walletTypeId;
  final DateTime crDate;
  final DateTime upsDate;
  final int balance;
  final int balanceHistory;
  final bool deflag;
  final String userId;
  final String? storeId;

  WalletEntity({
    required this.id,
    required this.walletTypeId,
    required this.crDate,
    required this.upsDate,
    required this.balance,
    required this.balanceHistory,
    required this.deflag,
    required this.userId,
    this.storeId,
  });

  // Convert đối tượng thành Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walletTypeId': walletTypeId,
      'crDate': crDate.toIso8601String(),
      'upsDate': upsDate.toIso8601String(),
      'balance': balance,
      'balanceHistory': balanceHistory,
      'deflag': deflag,
      'userId': userId,
      'storeId': storeId,
    };
  }

  // Tạo đối tượng từ Map
  factory WalletEntity.fromMap(Map<String, dynamic> map) {
    return WalletEntity(
      id: map['id'] ?? '',
      walletTypeId: map['walletTypeId'] ?? '',
      crDate: DateTime.parse(map['crDate'] ?? DateTime.now().toIso8601String()),
      upsDate:
          DateTime.parse(map['upsDate'] ?? DateTime.now().toIso8601String()),
      balance: (map['balance']?.toInt() ?? 0),
      balanceHistory: (map['balanceHistory']?.toInt() ?? 0),
      deflag: map['deflag'] ?? false,
      userId: map['userId'] ?? '',
      storeId: map['storeId'],
    );
  }

  // Chuyển đối tượng thành JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ JSON
  factory WalletEntity.fromJson(String source) =>
      WalletEntity.fromMap(json.decode(source));
}
