import 'dart:convert';

class ChangePasswordRequest {
  final String email;
  final String oldPassword;
  final String newPassword;
  final String apiKey;

  ChangePasswordRequest({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
    this.apiKey = '5f728deb-b2c3-4bac-9d9c-41a11e0acccc',
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'oldPassword': oldPassword});
    result.addAll({'email': email});
    result.addAll({'newPassword': newPassword});
    result.addAll({'apiKey': apiKey});

    return result;
  }

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      email: map['email'] ?? '',
      oldPassword: map['oldPassword'] ?? '',
      newPassword: map['newPassword'] ?? '',
      apiKey: map['apiKey'] ?? '5f728deb-b2c3-4bac-9d9c-41a11e0acccc',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordRequest.fromJson(String source) =>
      ChangePasswordRequest.fromMap(json.decode(source));
}
