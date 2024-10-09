import 'dart:convert';

import 'package:base/models/token_model.dart';

class AccountEntities {
  final String userId;
  final String email;
  final String roleName;
  final TokenModel tokens;

  AccountEntities({
    required this.userId,
    required this.email,
    required this.roleName,
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'email': email});
    result.addAll({'roleName': roleName});
    result.addAll({'tokens': tokens.toMap()});

    return result;
  }

  factory AccountEntities.fromMap(Map<String, dynamic> map) {
    return AccountEntities(
      userId: map['userId']  ?? '',
      email: map['email'] ?? '',
      roleName: map['roleName'] ?? '',
      tokens: TokenModel.fromMap(map['tokens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountEntities.fromJson(String source) =>
      AccountEntities.fromMap(json.decode(source));
}
