import 'dart:convert';

class PackageEntities {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int duration;
  final int price;
  final DateTime? crDate;
  final DateTime? upsDate;
  final String? marketZone; // Giá trị tùy chọn (nullable)

  PackageEntities({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.price,
    this.crDate,
    this.upsDate,
    this.marketZone,
  });

  // Chuyển đối tượng sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'crDate': crDate?.toIso8601String(),
      'upsDate': upsDate?.toIso8601String(),
      'marketZone': marketZone, // Thêm marketZone vào Map
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
      duration: map['duration']?.toInt() ?? 0,
      crDate: map['crDate'] != null ? DateTime.parse(map['crDate']) : null,
      upsDate: map['upsDate'] != null ? DateTime.parse(map['upsDate']) : null,
      marketZone: map['marketZone'], // Thêm marketZone từ Map
    );
  }

  // Chuyển đối tượng sang chuỗi JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ chuỗi JSON
  factory PackageEntities.fromJson(String source) =>
      PackageEntities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageEntities{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, crDate: $crDate, upsDate: $upsDate,Duration: $duration, marketZone: $marketZone}';
  }
}
