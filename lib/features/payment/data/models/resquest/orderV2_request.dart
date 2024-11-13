import 'dart:convert';

class OrderV2Request {
  final String? packageItemId;
  final int? chargeAmount; // Thay đổi từ double thành int
  final String cccdPassport;
  final String paymentType;

  // final String urlDirect;

  OrderV2Request({
    required this.packageItemId,
    required this.chargeAmount,
    required this.cccdPassport,
    required this.paymentType,

    // this.urlDirect = "vega://payment-result",
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (packageItemId != null) {
      result.addAll({'packageItemId': packageItemId});
    }
    if (chargeAmount != null) {
      result.addAll(
          {'chargeAmount': chargeAmount}); // Sử dụng chargeAmount là int
    }
    result.addAll({'cccdPassport': cccdPassport});
    // result.addAll({'urlDirect': urlDirect});
    result.addAll({'paymentType': paymentType});

    return result;
  }

  factory OrderV2Request.fromMap(Map<String, dynamic> map) {
    return OrderV2Request(
      packageItemId: map['packageItemId'] ?? '',
      chargeAmount: map['chargeAmount']?.toInt(), // Chuyển đổi về int
      cccdPassport: map['cccdPassport'] ?? '',
      // urlDirect: map['urlDirect'] ?? '',
      paymentType: map['paymentType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderV2Request.fromJson(String source) =>
      OrderV2Request.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'OrderRequest( etagCode: $etagCode, chargeAmount: $chargeAmount, cccd: $cccd, paymentType: $paymentType)';
  // }
}
