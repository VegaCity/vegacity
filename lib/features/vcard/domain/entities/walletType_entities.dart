import 'dart:convert';

class WalletType {
  final String name;

  WalletType({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }

  factory WalletType.fromMap(Map<String, dynamic> map) {
    return WalletType(
      name: map["name"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletType.fromJson(String source) => WalletType.fromMap(json.decode(source));
}
