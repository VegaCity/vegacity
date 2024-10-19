import 'dart:convert';

class CardEntities {
  final String id;
  final String etagCode;
  final String fullName;
  final String phoneNumber;
  final String cccd;
  final String imageUrl;
  final int gender;
  final DateTime birthday;
  final String qrCode;
  final bool deflag;
  final DateTime startDate;
  final DateTime endDate;
  final int status;

  CardEntities({
    required this.id,
    required this.etagCode,
    required this.fullName,
    required this.phoneNumber,
    required this.cccd,
    required this.imageUrl,
    required this.gender,
    required this.birthday,
    required this.qrCode,
    required this.deflag,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({"id": id});
    result.addAll({"etagCode": etagCode});
    result.addAll({"fullName": fullName});
    result.addAll({"phoneNumber": phoneNumber});
    result.addAll({"cccd": cccd});
    result.addAll({"imageUrl": imageUrl});
    result.addAll({"gender": gender});
    result.addAll({"birthday": birthday.toIso8601String()});
    result.addAll({"qrCode": qrCode});
    result.addAll({"deflag": deflag});
    result.addAll({"startDate": startDate.toIso8601String()});
    result.addAll({"endDate": endDate.toIso8601String()});
    result.addAll({"status": status});

    return result;
  }

  factory CardEntities.fromMap(Map<String, dynamic> map) {
    return CardEntities(
      id: map["id"] ?? '',
      etagCode: map["etagCode"] ?? '',
      fullName: map["fullName"] ?? '',
      phoneNumber: map["phoneNumber"] ?? '',
      cccd: map["cccd"] ?? '',
      imageUrl: map["imageUrl"] ?? '',
      gender: map["gender"] ?? 0,
      birthday: DateTime.parse(map["birthday"] ?? '1970-01-01T00:00:00'),
      qrCode: map["qrCode"] ?? '',
      deflag: map["deflag"] ?? false,
      startDate: DateTime.parse(map["startDate"] ?? '1970-01-01T00:00:00'),
      endDate: DateTime.parse(map["endDate"] ?? '1970-01-01T00:00:00'),
      status: map["status"] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardEntities.fromJson(String source) =>
      CardEntities.fromMap(json.decode(source));
}
