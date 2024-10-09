import 'dart:convert';

class SuccessModel {
  final int statusCode; 
  final String messageResponse;

  SuccessModel({
    required this.statusCode,
    required this.messageResponse,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode, 
      'messageResponse': messageResponse,
    };
  }

  factory SuccessModel.fromMap(Map<String, dynamic> map) {
    return SuccessModel(
      statusCode: map['statusCode']?.toInt() ?? 0,
      messageResponse: map['messageResponse'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuccessModel.fromJson(String source) =>
      SuccessModel.fromMap(json.decode(source));

  @override
  String toString() => 'Success: $messageResponse (Status Code: $statusCode)'; 
}
