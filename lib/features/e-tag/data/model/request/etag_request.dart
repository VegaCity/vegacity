import 'dart:convert';

class EtagRequest {
  final String? etagCode;

  EtagRequest({this.etagCode});

  Map<String, dynamic> toMap() {
    return {
      if (etagCode != null) 'etagCode': etagCode,
    };
  }

  factory EtagRequest.fromMap(Map<String, dynamic> map) {
    return EtagRequest(
      etagCode: map['etagCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagRequest.fromJson(String source) =>
      EtagRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EtagRequest(etagCode: $etagCode)';
  }
}
