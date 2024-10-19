import 'dart:convert';

class PaymentRequest {
  final String invoiceId;
  final String key;
  final String urlDirect;
  final String urlIpn;

  // Đặt giá trị mặc định cho urlDirect trong constructor
  PaymentRequest({
    required this.invoiceId,
    required this.key,
    required this.urlDirect,
    required this.urlIpn,
  });

  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'key': key,
      'urlDirect': urlDirect,
      'urlIpn': urlIpn,
    };
  }

  factory PaymentRequest.fromMap(Map<String, dynamic> map) {
    return PaymentRequest(
      invoiceId: map['invoiceId'] ?? '',
      key: map['key'] ?? '',
      // Sử dụng giá trị mặc định nếu map không có 'urlDirect'
      urlDirect: map['urlDirect'] ?? '',
      urlIpn: map['urlIpn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentRequest.fromJson(String source) =>
      PaymentRequest.fromMap(json.decode(source));
}
