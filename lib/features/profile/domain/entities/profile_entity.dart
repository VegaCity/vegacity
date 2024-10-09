import 'dart:convert';

import 'package:base/features/profile/domain/entities/user_entity.dart';

class ProfileEntity {
  final UserEntity user;

  ProfileEntity({
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      "user": user.toMap(),
    };
  }

  factory ProfileEntity.fromMap(Map<String, dynamic> map) {
    return ProfileEntity(
      user: UserEntity.fromMap(map["user"] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileEntity.fromJson(String source) =>
      ProfileEntity.fromMap(json.decode(source));
}
