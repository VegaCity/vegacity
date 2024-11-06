import 'dart:convert';

import 'package:base/features/vcard/domain/entities/packageItem_entity.dart';

class PackageitemResponse {
  final List<PackageItemEntities> data;

  PackageitemResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PackageitemResponse.fromMap(Map<String, dynamic> map) {
    return PackageitemResponse(
      data: List<PackageItemEntities>.from(
          map['data']?.map((x) => PackageItemEntities.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageitemResponse.fromJson(String source) =>
      PackageitemResponse.fromMap(json.decode(source));
}
