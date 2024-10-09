import 'dart:convert';

class ErrorModel {
  final int statusCode;
  final String messageResponse;
   final List<String> errors;

  ErrorModel({
    required this.statusCode,
    required this.messageResponse,
     required this.errors,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'messageResponse': messageResponse,
      'errors': errors,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      statusCode: map['statusCode']?.toInt() ?? 0,
      messageResponse: map['messageResponse'] ?? '',
       errors: List<String>.from(map['errors'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source));

  @override
  String toString() => 'Error: $messageResponse (Status Code: $statusCode)';
}