import 'dart:convert';

class PackageEntities {
  final String id;
  final String name;
  final String description;
  final int price;

  // final String? bookingId;

  PackageEntities({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    // this.bookingId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"name": name});
    result.addAll({"description": description});
    result.addAll({"price": price});
    // result.addAll({"bookingId": bookingId});

    return result;
  }

  factory PackageEntities.fromMap(Map<String, dynamic> map) {
    return PackageEntities(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      description: map["description"] ?? '',
      price: map["price"]?.toInt() ?? 0,
      //  bookingId: map["bookingId"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // @override
  // String toString() {
  //   return 'PackageEntities{id: $id, name: $name, description: $description, bookingId: $bookingId}';
  // }

  factory PackageEntities.fromJson(String source) =>
      PackageEntities.fromMap(json.decode(source));
}
