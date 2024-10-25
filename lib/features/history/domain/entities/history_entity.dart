import 'dart:convert';

class HistoryEntity {
  final String id;
  final String type;
  final String walletId;
  final String? storeId;
  final String status;
  final bool isIncrease;
  final String description;
  final DateTime crDate;
  final int amount;
  final String currency;

  HistoryEntity({
    required this.id,
    required this.type,
    required this.walletId,
    this.storeId,
    required this.status,
    required this.isIncrease,
    required this.description,
    required this.crDate,
    required this.amount,
    required this.currency,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'walletId': walletId,
      'storeId': storeId,
      'status': status,
      'isIncrease': isIncrease,
      'description': description,
      'crDate': crDate.toIso8601String(),
      'amount': amount,
      'currency': currency,
    };
  }

  // Create object from Map
  factory HistoryEntity.fromMap(Map<String, dynamic> map) {
    return HistoryEntity(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      walletId: map['walletId'] ?? '',
      storeId: map['storeId'],
      status: map['status'] ?? '',
      isIncrease: map['isIncrease'] ?? false,
      description: map['description'] ?? '',
      crDate: DateTime.parse(map['crDate']),
      amount: map['amount']?.toInt() ?? 0,
      currency: map['currency'] ?? '',
    );
  }

  // Convert object to JSON
  String toJson() => json.encode(toMap());

  // Create object from JSON
  factory HistoryEntity.fromJson(String source) =>
      HistoryEntity.fromMap(json.decode(source));
}
