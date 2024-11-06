import 'dart:convert';

class OrderRequest {
  final String? packageItemId;
  final int? chargeAmount; // Thay đổi từ double thành int
  final String cccdPassport;
  final String paymentType;
  // final String? promoCode;
  // final String urlDirect;

  OrderRequest({
    required this.packageItemId,
    required this.chargeAmount,
    required this.cccdPassport,
    required this.paymentType,
    // required this.promoCode,
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
    //  if (packageItemId != null) {
    //      result.addAll({'promoCode': promoCode});
    // }
 
    return result;
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      packageItemId: map['packageItemId'] ?? '',
      chargeAmount: map['chargeAmount']?.toInt(), // Chuyển đổi về int
      cccdPassport: map['cccdPassport'] ?? '',
      // urlDirect: map['urlDirect'] ?? '',
      paymentType: map['paymentType'] ?? '',
      // promoCode: map['promoCode'] ?? '',
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
