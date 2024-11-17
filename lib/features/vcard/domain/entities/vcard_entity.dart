import 'dart:convert';

import 'package:base/features/vcard/domain/entities/packageV2_entity.dart';
import 'package:base/features/vcard/domain/entities/wallet_entities.dart';

class VcardEntities {
  final String id;
  final String packageId;
  final String cusName;
  final String phoneNumber;
  final String? cusCccdpassport;
  final String vcardId;
  final String gender;
  // final DateTime birthday;
  final String cusEmail;
  final bool isAdult;
  final DateTime crDate;
  final DateTime upsDate;
  final String status;
  final String rfid;
  final List<Wallet> wallets;
  final Package package;

  VcardEntities({
    required this.id,
    required this.packageId,
    required this.cusName,
    required this.phoneNumber,
    required this.vcardId,
    this.cusCccdpassport,
    // required this.imageUrl,
    required this.gender,
    // required this.birthday,
    required this.cusEmail,
    required this.isAdult,
    required this.crDate,
    required this.upsDate,
    required this.status,
    required this.rfid,
    required this.wallets,
    required this.package,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"packageId": packageId});
    result.addAll({"cusName": cusName});
    result.addAll({"phoneNumber": phoneNumber});
    result.addAll({"cusCccdpassport": cusCccdpassport});
    result.addAll({"vcardId": vcardId});
    result.addAll({"gender": gender});
    // result.addAll({"birthday": birthday.toIso8601String()});
    result.addAll({"cusEmail": cusEmail});
    result.addAll({"isAdult": isAdult});
    result.addAll({"crDate": crDate.toIso8601String()});
    result.addAll({"upsDate": upsDate.toIso8601String()});
    result.addAll({"status": status});
    result.addAll({"rfid": rfid});
    result.addAll({
      "wallets": wallets.map((wallet) => wallet.toMap()).toList(),
    });
    result.addAll({"package": package.toMap()});
    return result;
  }

  factory VcardEntities.fromMap(Map<String, dynamic> map) {
    return VcardEntities(
      id: map["id"] ?? '',
      packageId: map["packageId"] ?? '',
      cusName: map["cusName"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      vcardId: map["vcardId"] ?? '',
      cusCccdpassport: map["cusCccdpassport"],
      // imageUrl: map["imageUrl"] ?? '',
      gender: map["gender"] ?? '',
      // birthday: DateTime.parse(map["birthday"] ?? '1970-01-01T00:00:00'),
      cusEmail: map["cusEmail"] ?? '',
      isAdult: map["isAdult"] ?? false,
      crDate: DateTime.parse(map["crDate"] ?? '1970-01-01T00:00:00'),
      upsDate: DateTime.parse(map["upsDate"] ?? '1970-01-01T00:00:00'),
      status: map["status"] ?? '',
      rfid: map["rfid"] ?? '',
      wallets: (map["wallets"] as List<dynamic>?)
              ?.map((wallet) => Wallet.fromMap(wallet))
              .toList() ??
          [],
      package: Package.fromMap(map["package"] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory VcardEntities.fromJson(String source) =>
      VcardEntities.fromMap(json.decode(source));
}
