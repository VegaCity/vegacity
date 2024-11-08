import 'dart:convert';

import 'package:base/features/vcard/domain/entities/wallet_entities.dart';

class VcardEntities {
  final String id;
  final String packageId;
  final String name;
  final String phoneNumber;
  final String? cccdpassport;
  // final String imageUrl;
  final String gender;
  // final DateTime birthday;
  final String email;
  final bool isAdult;
  final DateTime crDate;
  final DateTime upsDate;
  final String status;
  final String? rfid;
  final Wallet wallet;

  VcardEntities(
      {required this.id,
      required this.packageId,
      required this.name,
      required this.phoneNumber,
      this.cccdpassport,
      // required this.imageUrl,
      required this.gender,
      // required this.birthday,
      required this.email,
      required this.isAdult,
      required this.crDate,
      required this.upsDate,
      required this.status,
      this.rfid,
      required this.wallet,});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"packageId": packageId});
    result.addAll({"name": name});
    result.addAll({"phoneNumber": phoneNumber});
    result.addAll({"cccdpassport": cccdpassport});
    // result.addAll({"imageUrl": imageUrl});
    result.addAll({"gender": gender});
    // result.addAll({"birthday": birthday.toIso8601String()});
    result.addAll({"email": email});
    result.addAll({"isAdult": isAdult});
    result.addAll({"crDate": crDate.toIso8601String()});
    result.addAll({"upsDate": upsDate.toIso8601String()});
    result.addAll({"status": status});
    result.addAll({"rfid": rfid});
    result.addAll({"wallet": wallet.toMap()});
    return result;
  }

  factory VcardEntities.fromMap(Map<String, dynamic> map) {
    return VcardEntities(
      id: map["id"] ?? '',
      packageId: map["packageId"] ?? '',
      name: map["name"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      cccdpassport: map["cccdpassport"],
      // imageUrl: map["imageUrl"] ?? '',
      gender: map["gender"] ?? '',
      // birthday: DateTime.parse(map["birthday"] ?? '1970-01-01T00:00:00'),
      email: map["email"] ?? '',
      isAdult: map["isAdult"] ?? false,
      crDate: DateTime.parse(map["crDate"] ?? '1970-01-01T00:00:00'),
      upsDate: DateTime.parse(map["upsDate"] ?? '1970-01-01T00:00:00'),
      status: map["status"] ?? '',
      rfid: map["rfid"],
      wallet: Wallet.fromMap(map["wallet"] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory VcardEntities.fromJson(String source) =>
      VcardEntities.fromMap(json.decode(source));
}
