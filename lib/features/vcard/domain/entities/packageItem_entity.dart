import 'dart:convert';

class PackageItemEntities {
  final String id;
  final String packageId;
  final String name;
  final String phoneNumber;
  final String cccdPassport;
  // final String imageUrl;
  final String gender;
  // final DateTime birthday;
  final String email;
  final bool isAdult;
  final DateTime crDate;
  final DateTime upsDate;
  final String status;

  PackageItemEntities({
    required this.id,
    required this.packageId,
    required this.name,
    required this.phoneNumber,
    required this.cccdPassport,
    // required this.imageUrl,
    required this.gender,
    // required this.birthday,
    required this.email,
    required this.isAdult,
    required this.crDate,
    required this.upsDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"packageId": packageId});
    result.addAll({"name": name});
    result.addAll({"phoneNumber": phoneNumber});
    result.addAll({"cccdPassport": cccdPassport});
    // result.addAll({"imageUrl": imageUrl});
    result.addAll({"gender": gender});
    // result.addAll({"birthday": birthday.toIso8601String()});
    result.addAll({"email": email});
    result.addAll({"isAdult": isAdult});
    result.addAll({"crDate": crDate.toIso8601String()});
    result.addAll({"upsDate": upsDate.toIso8601String()});
    result.addAll({"status": status});

    return result;
  }

  factory PackageItemEntities.fromMap(Map<String, dynamic> map) {
    return PackageItemEntities(
      id: map["id"] ?? '',
      packageId: map["packageId"] ?? '',
      name: map["name"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      cccdPassport: map["cccdPassport"] ?? '',
      // imageUrl: map["imageUrl"] ?? '',
      gender: map["gender"] ?? '',
      // birthday: DateTime.parse(map["birthday"] ?? '1970-01-01T00:00:00'),
      email: map["email"] ?? '',
      isAdult: map["isAdult"] ?? false,
      crDate: DateTime.parse(map["crDate"] ?? '1970-01-01T00:00:00'),
      upsDate: DateTime.parse(map["upsDate"] ?? '1970-01-01T00:00:00'),
      status: map["status"] ?? '',
      // status: map["status"] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageItemEntities.fromJson(String source) =>
      PackageItemEntities.fromMap(json.decode(source));
}
