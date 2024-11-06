import 'dart:convert';
import 'package:base/features/vcard/domain/entities/etag_details_entity.dart';
import 'package:base/features/vcard/domain/entities/etag_type_entity.dart';

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
  final DateTime? crDate;
  final DateTime? upsDate;
  final bool deflag;
  final String etagTypeId;
  final String marketZoneId;
  final String walletId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int status;
  final bool isAdult;
  final EtagType etagType;
  final EtagDetails etagDetail;

  EtagEntity({
    required this.id,
    this.imageUrl,
    required this.qrcode,
    required this.etagCode,
    this.crDate,
    this.upsDate,
    required this.deflag,
    required this.etagTypeId,
    required this.marketZoneId,
    required this.walletId,
    this.startDate,
    this.endDate,
    required this.status,
    required this.isAdult,
    required this.etagType,
    required this.etagDetail,
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
      // 'startDate': startDate?.toIso8601String(),
      // 'endDate': endDate?.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'isAdult': isAdult,
      'etagType': etagType.toMap(),
      'etagDetail': etagDetail.toMap(),
    };
  }

  factory EtagEntity.fromMap(Map<String, dynamic> map) {
    return EtagEntity(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'],
      qrcode: map['qrcode'] ?? '',
      etagCode: map['etagCode'] ?? '',
      crDate: map['crDate'] != null ? DateTime.tryParse(map['crDate']) : null,
      upsDate:
          map['upsDate'] != null ? DateTime.tryParse(map['upsDate']) : null,
      deflag: map['deflag'] ?? false,
      etagTypeId: map['etagTypeId'] ?? '',
      marketZoneId: map['marketZoneId'] ?? '',
      walletId: map['walletId'] ?? '',
      // startDate: DateTime.parse(map['startDate']),
      // endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      startDate:
          map['startDate'] != null ? DateTime.tryParse(map['startDate']) : null,
      endDate:
          map['endDate'] != null ? DateTime.tryParse(map['endDate']) : null,
      status: map['status']?.toInt() ?? 0,
      isAdult: map['isAdult'] ?? false,
      etagType: EtagType.fromMap(map['etagType'] ?? {}),
      etagDetail: EtagDetails.fromMap(map['etagDetail'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagEntity.fromJson(String source) =>
      EtagEntity.fromMap(json.decode(source));
}
