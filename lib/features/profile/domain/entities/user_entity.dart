import 'dart:convert';

import 'package:base/features/profile/domain/entities/role_entity.dart';

class UserEntity {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? birthday;
  final String? storeId;
  final String crDate;
  final String upsDate;
  final int gender;
  final String cccd;
  final String? imageUrl;
  final String marketZoneId;
  final String email;
  final String password;
  final String roleId;
  final String description;
  final bool isChange;
  final String address;
  final int status;
  final Role role;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.birthday,
    this.storeId,
    required this.crDate,
    required this.upsDate,
    required this.gender,
    required this.cccd,
    this.imageUrl,
    required this.marketZoneId,
    required this.email,
    required this.password,
    required this.roleId,
    required this.description,
    required this.isChange,
    required this.address,
    required this.status,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "birthday": birthday,
      "storeId": storeId,
      "crDate": crDate,
      "upsDate": upsDate,
      "gender": gender,
      "cccd": cccd,
      "imageUrl": imageUrl,
      "marketZoneId": marketZoneId,
      "email": email,
      "password": password,
      "roleId": roleId,
      "description": description,
      "isChange": isChange,
      "address": address,
      "status": status,
      "role": role.toMap(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map["id"] ?? '',
      fullName: map["fullName"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      birthday: map["birthday"],
      storeId: map["storeId"],
      crDate: map["crDate"] ?? '',
      upsDate: map["upsDate"] ?? '',
      gender: map["gender"]?.toInt() ?? 0,
      cccd: map["cccd"] ?? '',
      imageUrl: map["imageUrl"],
      marketZoneId: map["marketZoneId"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
      roleId: map["roleId"] ?? '',
      description: map["description"] ?? '',
      isChange: map["isChange"] ?? false,
      address: map["address"] ?? '',
      status: map["status"]?.toInt() ?? 0,
      role: Role.fromMap(map["role"] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));
}
