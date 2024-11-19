import 'dart:convert';

class PackageItemEntities {
  final String id;
  final String packageId;
  final String cusName;
  final String phoneNumber;
  final String? cusCccdpassport;
  // final String imageUrl;
  final String gender;
  // final DateTime birthday;
  final String email;
  final bool isAdult;
  final DateTime crDate;
  final DateTime upsDate;
  final String status;
  final String? walletTypeName;

  PackageItemEntities({
    required this.id,
    required this.packageId,
    required this.cusName,
    required this.phoneNumber,
    this.cusCccdpassport,
    // required this.imageUrl,
    required this.gender,
    // required this.birthday,
    required this.email,
    required this.isAdult,
    required this.crDate,
    required this.upsDate,
    required this.status,
    this.walletTypeName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"packageId": packageId});
    result.addAll({"cusName": cusName});
    result.addAll({"phoneNumber": phoneNumber});
    result.addAll({"cusCccdpassport": cusCccdpassport});
    // result.addAll({"imageUrl": imageUrl});
    result.addAll({"gender": gender});
    // result.addAll({"birthday": birthday.toIso8601String()});
    result.addAll({"email": email});
    result.addAll({"isAdult": isAdult});
    result.addAll({"crDate": crDate.toIso8601String()});
    result.addAll({"upsDate": upsDate.toIso8601String()});
    result.addAll({"status": status});
    result.addAll({"walletTypeName": walletTypeName});
    return result;
  }

  factory PackageItemEntities.fromMap(Map<String, dynamic> map) {
    return PackageItemEntities(
      id: map["id"] ?? '',
      packageId: map["packageId"] ?? '',
      cusName: map["cusName"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      cusCccdpassport: map["cusCccdpassport"],
      // imageUrl: map["imageUrl"] ?? '',
      gender: map["gender"] ?? '',
      // birthday: DateTime.parse(map["birthday"] ?? '1970-01-01T00:00:00'),
      email: map["email"] ?? '',
      isAdult: map["isAdult"] ?? false,
      crDate: DateTime.parse(map["crDate"] ?? '1970-01-01T00:00:00'),
      upsDate: DateTime.parse(map["upsDate"] ?? '1970-01-01T00:00:00'),
      status: map["status"] ?? '',
      walletTypeName: map["walletTypeName"],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageItemEntities.fromJson(String source) =>
      PackageItemEntities.fromMap(json.decode(source));
}
