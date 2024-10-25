// import 'dart:convert';
// import 'package:base/features/e-tag/domain/entities/etag_type_entity.dart';

// class EtagParentEntity {
//   final EtagEntity etag;

//   EtagParentEntity({required this.etag});

//   Map<String, dynamic> toMap() {
//     return {
//       'etag': etag.toMap(),
//     };
//   }

//   factory EtagParentEntity.fromMap(Map<String, dynamic> map) {
//     return EtagParentEntity(
//       etag: EtagEntity.fromMap(map['etag'] ?? {}),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory EtagParentEntity.fromJson(String source) =>
//       EtagParentEntity.fromMap(json.decode(source));
// }

// class EtagEntity {
//   final String id;
//   final String fullName;
//   final String phoneNumber;
//   final String? birthday;
//   final String? cccdPassport;
//   final String? imageUrl;
//   final int gender;
//   final String qrcode;
//   final String etagCode;
//   final String crDate;
//   final String upsDate;
//   final bool deflag;
//   final String etagTypeId;
//   final String marketZoneId;
//   final String walletId;
//   final DateTime startDate;
//   final DateTime endDate;
//   final int status;
//   final bool isVerifyPhone;
//   final EtagType etagType;

//   EtagEntity({
//     required this.id,
//     required this.fullName,
//     required this.phoneNumber,
//     this.birthday,
//     this.cccdPassport,
//     this.imageUrl,
//     required this.gender,
//     required this.qrcode,
//     required this.etagCode,
//     required this.crDate,
//     required this.upsDate,
//     required this.deflag,
//     required this.etagTypeId,
//     required this.marketZoneId,
//     required this.walletId,
//     required this.startDate,
//     required this.endDate,
//     required this.status,
//     required this.isVerifyPhone,
//     required this.etagType,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "fullName": fullName,
//       "phoneNumber": phoneNumber,
//       "birthday": birthday,
//       "cccdPassport": cccdPassport,
//       "imageUrl": imageUrl,
//       "gender": gender,
//       "qrcode": qrcode,
//       "etagCode": etagCode,
//       "crDate": crDate,
//       "upsDate": upsDate,
//       "deflag": deflag,
//       "etagTypeId": etagTypeId,
//       "marketZoneId": marketZoneId,
//       "walletId": walletId,
//       "startDate": startDate.toIso8601String(),
//       "endDate": endDate.toIso8601String(),
//       "status": status,
//       "isVerifyPhone": isVerifyPhone,
//       "etagType": etagType.toMap(),
//     };
//   }

//   factory EtagEntity.fromMap(Map<String, dynamic> map) {
//     return EtagEntity(
//       id: map["id"] ?? '',
//       fullName: map["fullName"] ?? '',
//       phoneNumber: map["phoneNumber"] ?? '',
//       birthday: map["birthday"],
//       cccdPassport: map["cccdPassport"] ?? '',
//       imageUrl: map["imageUrl"],
//       gender: map["gender"]?.toInt() ?? 0,
//       qrcode: map["qrcode"] ?? '',
//       etagCode: map["etagCode"] ?? '',
//       crDate: map["crDate"] ?? '',
//       upsDate: map["upsDate"] ?? '',
//       deflag: map["deflag"] ?? false,
//       etagTypeId: map["etagTypeId"] ?? '',
//       marketZoneId: map["marketZoneId"] ?? '',
//       walletId: map["walletId"] ?? '',
//       startDate: DateTime.parse(map["startDate"]),
//       endDate: DateTime.parse(map["endDate"]),
//       status: map["status"]?.toInt() ?? 0,
//       isVerifyPhone: map["isVerifyPhone"] ?? false,
//       etagType: EtagType.fromMap(map["etagType"] ?? {}),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory EtagEntity.fromJson(String source) =>
//       EtagEntity.fromMap(json.decode(source));
// }
import 'dart:convert';
import 'package:base/features/e-tag/domain/entities/etag_details_entity.dart';
import 'package:base/features/e-tag/domain/entities/etag_type_entity.dart';

class EtagParentEntity {
  final EtagEntity etag;

  EtagParentEntity({required this.etag});

  Map<String, dynamic> toMap() {
    return {'etag': etag.toMap()};
  }

  factory EtagParentEntity.fromMap(Map<String, dynamic> map) {
    return EtagParentEntity(
      etag: EtagEntity.fromMap(map['etag'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagParentEntity.fromJson(String source) =>
      EtagParentEntity.fromMap(json.decode(source));
}

class EtagEntity {
  final String id;
  final String? imageUrl;
  final String qrcode;
  final String etagCode;
  final String crDate;
  final String upsDate;
  final bool deflag;
  final String etagTypeId;
  final String marketZoneId;
  final String walletId;
  final DateTime startDate;
  final DateTime? endDate;
  final int status;
  final bool isAdult;
  final EtagType etagType;
  final EtagDetails etagDetails;

  EtagEntity({
    required this.id,
    this.imageUrl,
    required this.qrcode,
    required this.etagCode,
    required this.crDate,
    required this.upsDate,
    required this.deflag,
    required this.etagTypeId,
    required this.marketZoneId,
    required this.walletId,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.isAdult,
    required this.etagType,
    required this.etagDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'qrcode': qrcode,
      'etagCode': etagCode,
      'crDate': crDate,
      'upsDate': upsDate,
      'deflag': deflag,
      'etagTypeId': etagTypeId,
      'marketZoneId': marketZoneId,
      'walletId': walletId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'isAdult': isAdult,
      'etagType': etagType.toMap(),
      'etagDetails': etagDetails.toMap(),
    };
  }

  factory EtagEntity.fromMap(Map<String, dynamic> map) {
    return EtagEntity(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'],
      qrcode: map['qrcode'] ?? '',
      etagCode: map['etagCode'] ?? '',
      crDate: map['crDate'] ?? '',
      upsDate: map['upsDate'] ?? '',
      deflag: map['deflag'] ?? false,
      etagTypeId: map['etagTypeId'] ?? '',
      marketZoneId: map['marketZoneId'] ?? '',
      walletId: map['walletId'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      status: map['status']?.toInt() ?? 0,
      isAdult: map['isAdult'] ?? false,
      etagType: EtagType.fromMap(map['etagType'] ?? {}),
      etagDetails: EtagDetails.fromMap(map['etagDetails'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagEntity.fromJson(String source) =>
      EtagEntity.fromMap(json.decode(source));
}


