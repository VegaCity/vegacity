import 'dart:convert';

import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';

class ProfileResponse {
  final ProfileEntity data;

  ProfileResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.toMap()});

    return result;
  }

  factory ProfileResponse.fromMap(Map<String, dynamic> map) {
    return ProfileResponse(
      data: ProfileEntity.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileResponse.fromJson(String source) =>
      ProfileResponse.fromMap(json.decode(source));
}
