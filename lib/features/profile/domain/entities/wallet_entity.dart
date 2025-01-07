import 'dart:convert';

class WalletEntity {
  final String id;
  final String userId;
  final String userName;
  final String? storeId;
  final DateTime dateCheck;
  final int balance;
  final int balanceHistory;

  WalletEntity({
    required this.id,
    required this.userId,
    required this.userName,
    this.storeId,
    required this.dateCheck,
    required this.balance,
    required this.balanceHistory,
  });

  // Convert đối tượng thành Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'storeId': storeId,
      'dateCheck': dateCheck.toIso8601String(),
      'balance': balance,
      'balanceHistory': balanceHistory,
    };
  }

  // Tạo đối tượng từ Map
  factory WalletEntity.fromMap(Map<String, dynamic> map) {
    return WalletEntity(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      storeId: map['storeId'],
      dateCheck:
          DateTime.parse(map['dateCheck'] ?? DateTime.now().toIso8601String()),
      balance: (map['balance']?.toInt() ?? 0),
      balanceHistory: (map['balanceHistory']?.toInt() ?? 0),
    );
  }

  // Chuyển đối tượng thành JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ JSON
  factory WalletEntity.fromJson(String source) =>
      WalletEntity.fromMap(json.decode(source));
}
