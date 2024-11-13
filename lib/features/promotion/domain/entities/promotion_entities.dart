import 'dart:convert';

class PromotionEntities {
  final String id;
  final String marketZoneId;
  final String name;
  final String promotionCode;
  final String description;
  final int maxDiscount;
  final int requireAmount;
  final int quantity;

  final int status;
  final DateTime startDate;
  final DateTime endDate;
  final String? marketZone;

  PromotionEntities({
    required this.id,
    required this.marketZoneId,
    required this.name,
    required this.promotionCode,
    required this.description,
    required this.maxDiscount,
    required this.requireAmount,
    required this.quantity,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.marketZone,
  });

  // Chuyển đối tượng sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marketZoneId': marketZoneId,
      'name': name,
      'promotionCode': promotionCode,
      'description': description,
      'maxDiscount': maxDiscount,
      'requireAmount': requireAmount,
      'quantity': quantity,
      'status': status,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'marketZone': marketZone,
    };
  }

  // Tạo đối tượng từ Map, với xử lý các trường hợp lỗi tiềm ẩn
  factory PromotionEntities.fromMap(Map<String, dynamic> map) {
    return PromotionEntities(
      id: map['id'] ?? '',
      marketZoneId: map['marketZoneId'] ?? '',
      name: map['name'] ?? '',
      promotionCode: map['promotionCode'] ?? '',
      description: map['description'] ?? '',
      maxDiscount: map['maxDiscount']?.toInt() ?? 0,
      requireAmount: map['requireAmount']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      marketZone: map['marketZone'],
    );
  }

  // Chuyển đối tượng sang chuỗi JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ chuỗi JSON
  factory PromotionEntities.fromJson(String source) =>
      PromotionEntities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromotionEntities{id: $id, marketZoneId: $marketZoneId, name: $name, promotionCode: $promotionCode, description: $description, maxDiscount: $maxDiscount, requireAmount: $requireAmount, quantity: $quantity, status: $status, startDate: $startDate, endDate: $endDate, marketZone: $marketZone}';
  }
}
