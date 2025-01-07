import 'dart:convert';

class TransactionEntity {
  final String id;
  final String paymentType;
  final String name;
  final int totalAmount;
  final DateTime crDate;
  final String status;
  final String invoiceId;
  final String? storeId;
  final String? etagId;
  final String userId;
  final String? etagTypeId;
  final String? packageId;
  final String? details;

  TransactionEntity({
    required this.id,
    required this.paymentType,
    required this.name,
    required this.totalAmount,
    required this.crDate,
    required this.status,
    required this.invoiceId,
    this.storeId,
    this.etagId,
    required this.userId,
    this.etagTypeId,
    this.packageId,
    this.details,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentType': paymentType,
      'name': name,
      'totalAmount': totalAmount,
      'crDate': crDate.toIso8601String(),
      'status': status,
      'invoiceId': invoiceId,
      'storeId': storeId,
      'etagId': etagId,
      'userId': userId,
      'etagTypeId': etagTypeId,
      'packageId': packageId,
      'details': details,
    };
  }

  // Create object from Map
  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'] ?? '',
      paymentType: map['paymentType'] ?? '',
      name: map['name'] ?? '',
      totalAmount: map['totalAmount']?.toInt() ?? 0,
      crDate: DateTime.parse(map['crDate']),
      status: map['status'] ?? '',
      invoiceId: map['invoiceId'] ?? '',
      storeId: map['storeId'],
      etagId: map['etagId'],
      userId: map['userId'] ?? '',
      etagTypeId: map['etagTypeId'],
      packageId: map['packageId'],
      details: map['details'],
    );
  }

  // Convert object to JSON
  String toJson() => json.encode(toMap());

  // Create object from JSON
  factory TransactionEntity.fromJson(String source) =>
      TransactionEntity.fromMap(json.decode(source));
}
