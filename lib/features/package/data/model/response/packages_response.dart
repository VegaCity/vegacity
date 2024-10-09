import 'dart:convert';

import 'package:base/features/package/domain/entities/packages_entities.dart';

class PackageResponse {
  final List<PackageEntities> data;

  PackageResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PackageResponse.fromMap(Map<String, dynamic> map) {
    return PackageResponse(
      data: List<PackageEntities>.from(
          map['data']?.map((x) => PackageEntities.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageResponse.fromJson(String source) =>
      PackageResponse.fromMap(json.decode(source));
}
