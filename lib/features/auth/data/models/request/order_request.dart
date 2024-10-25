import 'dart:convert';

class OrderRequest {
  final String? etagCode;
  final int? chargeAmount; // Thay đổi từ double thành int
  final String cccdPassport;
  final String paymentType;
  // final String urlDirect;

  OrderRequest({
    required this.etagCode,
    required this.chargeAmount,
    required this.cccdPassport,
    required this.paymentType,
    // this.urlDirect = "vega://payment-result",
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (etagCode != null) {
      result.addAll({'etagCode': etagCode});
    }
    if (chargeAmount != null) {
      result.addAll({'chargeAmount': chargeAmount}); // Sử dụng chargeAmount là int
    }
    result.addAll({'cccdPassport': cccdPassport});
    // result.addAll({'urlDirect': urlDirect});
    result.addAll({'paymentType': paymentType});

    return result;
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      etagCode: map['etagCode'] ?? '',
      chargeAmount: map['chargeAmount']?.toInt(), // Chuyển đổi về int
      cccdPassport: map['cccdPassport'] ?? '',
      // urlDirect: map['urlDirect'] ?? '',
      paymentType: map['paymentType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRequest.fromJson(String source) =>
      OrderRequest.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'OrderRequest( etagCode: $etagCode, chargeAmount: $chargeAmount, cccd: $cccd, paymentType: $paymentType)'; 
  // }
}
