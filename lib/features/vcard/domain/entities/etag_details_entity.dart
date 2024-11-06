import 'dart:convert';

class EtagDetails {
  final String id;
  final String etagId;
  final String fullName;
  final String phoneNumber;
  final String? cccdPassport;
  final int gender;
  final DateTime? birthday;
  final bool isVerifyPhone;
  final DateTime? crDate;
  final DateTime? upsDate;

  EtagDetails({
    required this.id,
    required this.etagId,
    required this.fullName,
    required this.phoneNumber,
    this.cccdPassport,
    required this.gender,
    this.birthday,
    required this.isVerifyPhone,
    this.crDate,
    this.upsDate,
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
      // birthday: map['birthday'],
      birthday:
          map['birthday'] != null ? DateTime.tryParse(map['birthday']) : null,
      isVerifyPhone: map['isVerifyPhone'] ?? false,
      // crDate: map['crDate'] ?? '',
      // upsDate: map['upsDate'] ?? '',
      crDate: map['crDate'] != null ? DateTime.tryParse(map['crDate']) : null,
      upsDate:
          map['upsDate'] != null ? DateTime.tryParse(map['upsDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EtagDetails.fromJson(String source) =>
      EtagDetails.fromMap(json.decode(source));
}
