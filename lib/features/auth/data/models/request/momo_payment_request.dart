import 'dart:convert';

class MomoPaymentRequest {
  final String invoiceId; // New: Added invoiceId for consistency.
  final String key; // New: Added key as per response structure.
  final String urlDirect; // New: Include urlDirect for payment redirect.
  final String urlIpn; // New: Include IPN URL for order status updates.

  MomoPaymentRequest({
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

  factory MomoPaymentRequest.fromMap(Map<String, dynamic> map) {
    return MomoPaymentRequest(
      invoiceId: map['invoiceId'] ?? '',
      key: map['key'] ?? '',
      urlDirect: map['urlDirect'] ?? '',
      urlIpn: map['urlIpn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoPaymentRequest.fromJson(String source) =>
      MomoPaymentRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MomoPaymentRequest( invoiceId: $invoiceId, '
        'key: $key, urlDirect: $urlDirect, urlIpn: $urlIpn)';
  }
}
