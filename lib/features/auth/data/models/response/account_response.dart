import 'dart:convert';

import 'package:base/features/auth/domain/entities/account_entities.dart';

class AccountReponse {
  final AccountEntities data;

  AccountReponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data.toMap()});

    return result;
  }

  factory AccountReponse.fromMap(Map<String, dynamic> map) {
    return AccountReponse(
      data: AccountEntities.fromMap(map["data"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountReponse.fromJson(String source) =>
      AccountReponse.fromMap(json.decode(source));
}
