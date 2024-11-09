import 'dart:convert';

class OrderEntities {
  final String invoiceId;
  final int balance;
  final String key;
  final String urlDirect;
  final String urlIpn;
  final String packageItemId;
  final String packageOrderId;
  final String transactionChargeId;

  OrderEntities({
    required this.invoiceId,
    required this.balance,
    required this.key,
    required this.urlDirect,
    required this.urlIpn,
    required this.packageItemId,
    required this.packageOrderId,
    required this.transactionChargeId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'invoiceId': invoiceId});
    result.addAll({'balance': balance});
    result.addAll({'key': key});
    result.addAll({'urlDirect': urlDirect});
    result.addAll({'urlIpn': urlIpn});
    result.addAll({
      'packageItemId': packageItemId,
    });
    result.addAll({
      'packageOrderId': packageOrderId,
    });
    result.addAll({
      'transactionChargeId': transactionChargeId,
    });
    return result;
  }

  factory OrderEntities.fromMap(Map<String, dynamic> map) {
    return OrderEntities(
      invoiceId: map['invoiceId'] ?? '',
      balance: map['balance'] ?? 0,
      key: map['key'] ?? '',
      urlDirect: map['urlDirect'] ?? '',
      urlIpn: map['urlIpn'] ?? '',
      packageItemId: map['packageItemId'] ?? '',
      packageOrderId: map['packageOrderId'] ?? '',
      transactionChargeId: map['transactionChargeId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderEntities.fromJson(String source) =>
      OrderEntities.fromMap(json.decode(source));
}
