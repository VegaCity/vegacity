import 'dart:convert';

class EtagDetails {
  final String id;
  final String etagId;
  final String fullName;
  final String phoneNumber;
  final String? cccdPassport;
  final int gender;
  final String? birthday;
  final bool isVerifyPhone;
  final String crDate;
  final String upsDate;

  EtagDetails({
    required this.id,
    required this.etagId,
    required this.fullName,
    required this.phoneNumber,
    this.cccdPassport,
    required this.gender,
    this.birthday,
    required this.isVerifyPhone,
    required this.crDate,
    required this.upsDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'etagId': etagId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'cccdPassport': cccdPassport,
      'gender': gender,
      'birthday': birthday,
      'isVerifyPhone': isVerifyPhone,
      'crDate': crDate,
      'upsDate': upsDate,
    };
  }

  factory EtagDetails.fromMap(Map<String, dynamic> map) {
    return EtagDetails(
      id: map['id'] ?? '',
      etagId: map['etagId'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      cccdPassport: map['cccdPassport'],
      gender: map['gender']?.toInt() ?? 0,
      birthday: map['birthday'],
      isVerifyPhone: map['isVerifyPhone'] ?? false,
      crDate: map['crDate'] ?? '',
      upsDate: map['upsDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagDetails.fromJson(String source) =>
      EtagDetails.fromMap(json.decode(source));
}