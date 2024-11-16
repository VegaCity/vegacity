import 'dart:convert';

class PackageEntities {
  final String id;
  final String type;
  final String name;
  final String description;
  final String imageUrl;
  final int duration;
  final int price;
  final DateTime? crDate;
  final DateTime? upsDate;

  PackageEntities({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.price,
    this.crDate,
    this.upsDate,
  });

  // Chuyển đối tượng sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'crDate': crDate?.toIso8601String(),
      'upsDate': upsDate?.toIso8601String(),
    };
  }

  // Tạo đối tượng từ Map, với xử lý các trường hợp lỗi tiềm ẩn
  factory PackageEntities.fromMap(Map<String, dynamic> map) {
    return PackageEntities(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      crDate: map['crDate'] != null ? DateTime.parse(map['crDate']) : null,
      upsDate: map['upsDate'] != null ? DateTime.parse(map['upsDate']) : null,
    );
  }

  // Chuyển đối tượng sang chuỗi JSON
  String toJson() => json.encode(toMap());

  // Tạo đối tượng từ chuỗi JSON
  factory PackageEntities.fromJson(String source) =>
      PackageEntities.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageEntities{id: $id, name: $name,type: $type,description: $description, price: $price, imageUrl: $imageUrl, crDate: $crDate, upsDate: $upsDate,Duration: $duration}';
  }
}
