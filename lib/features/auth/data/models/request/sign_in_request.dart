import 'dart:convert';

class SignInRequest {
  final String email;

  final String password;

  SignInRequest({
     required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'password': password});
    result.addAll({'email': email});

    return result;
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  @override 
  String toString() {
    return 'SignUpRequest(email: $email , password: $password)';
  }

  factory SignInRequest.fromJson(String source) =>
      SignInRequest.fromMap(json.decode(source));
}
