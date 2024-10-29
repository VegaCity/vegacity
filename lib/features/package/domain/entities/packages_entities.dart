import 'dart:convert';

class PackageEntities {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final DateTime? startDate;
  final DateTime? endDate;
  // final String? bookingId; // Giá trị tùy chọn (nullable)

  PackageEntities({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.startDate,
    this.endDate,
    // this.bookingId,
  });

  // Chuyển đối tượng sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'startDate': startDate?.toIso8601String(), // Chuyển đổi nếu có
      'endDate': endDate?.toIso8601String(), // Chuyển đổi nếu có
      // 'bookingId': bookingId,
    };
  }

  // Tạo đối tượng từ Map, với xử lý các trường hợp lỗi tiềm ẩn
  factory PackageEntities.fromMap(Map<String, dynamic> map) {
    return PackageEntities(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,

      // bookingId: map['bookingId'],
    );
  }

  // Chuyển đối tượng sang chuỗi JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ chuỗi JSON
  factory PackageEntities.fromJson(String source) =>
      PackageEntities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageEntities{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, startDate: $startDate, endDate: $endDate}';
  }
}
