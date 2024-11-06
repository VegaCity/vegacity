import 'dart:convert';

class PaymentEntity {
  final String? partnerCode;
  final String? orderId;
  final String? requestId;
  final int? amount;
  final String? responseTime;
  final String? message;
  final int? resultCode;
  final String? payUrl;
  final String? shortLink;
  final String? qrCodeUrl;
  final String? paymentMethod;
  final String? orderDescription;
  final String? crDate;
  final String? vnPayResponse;

  // PayOS fields
  final String? bin;
  final String? accountNumber;
  final String? description;
  final int? orderCode;
  final String? currency;
  final String? paymentLinkId;
  final String? status;
  final String? checkoutUrl;
  final String? qrCode;

  // ZaloPay fields
  final int? returncode;
  final String? return_message;
  final int? sub_return_code;
  final String? sub_return_message;
  final String? order_url;
  final String? zp_trans_token;
  final String? order_token;
  final bool? qr_code;

  PaymentEntity({
    this.partnerCode,
    this.orderId,
    this.requestId,
    this.amount,
    this.responseTime,
    this.message,
    this.resultCode,
    this.payUrl,
    this.shortLink,
    this.qrCodeUrl,
    this.paymentMethod,
    this.orderDescription,
    this.crDate,
    this.vnPayResponse,
    this.bin,
    this.accountNumber,
    this.description,
    this.orderCode,
    this.currency,
    this.paymentLinkId,
    this.status,
    this.checkoutUrl,
    this.qrCode,
    this.returncode,
    this.return_message,
    this.sub_return_code,
    this.sub_return_message,
    this.order_url,
    this.zp_trans_token,
    this.order_token,
    this.qr_code,
  });

  Map<String, dynamic> toMap() {
    return {
      'partnerCode': partnerCode,
      'orderId': orderId,
      'requestId': requestId,
      'amount': amount,
      'responseTime': responseTime,
      'message': message,
      'resultCode': resultCode,
      'payUrl': payUrl,
      'shortLink': shortLink,
      'qrCodeUrl': qrCodeUrl,
      'paymentMethod': paymentMethod,
      'orderDescription': orderDescription,
      'crDate': crDate,
      'vnPayResponse': vnPayResponse,
      'bin': bin,
      'accountNumber': accountNumber,
      'description': description,
      'orderCode': orderCode,
      'currency': currency,
      'paymentLinkId': paymentLinkId,
      'status': status,
      'checkoutUrl': checkoutUrl,
      'qrCode': qrCode,
      'returncode': returncode,
      'return_message': return_message,
      'sub_return_code': sub_return_code,
      'sub_return_message': sub_return_message,
      'order_url': order_url,
      'zp_trans_token': zp_trans_token,
      'order_token': order_token,
      'qr_code': qr_code,
    };
  }

  factory PaymentEntity.fromMap(Map<String, dynamic> map) {
    return PaymentEntity(
      partnerCode: map['partnerCode'],
      orderId: map['orderId'],
      requestId: map['requestId'],
      amount: map['amount'],
      responseTime: map['responseTime'],
      message: map['message'],
      resultCode: map['resultCode'],
      payUrl: map['payUrl'],
      shortLink: map['shortLink'],
      qrCodeUrl: map['qrCodeUrl'],
      paymentMethod: map['paymentMethod'],
      orderDescription: map['orderDescription'],
      crDate: map['crDate'],
      vnPayResponse: map['vnPayResponse'],
      bin: map['bin'],
      accountNumber: map['accountNumber'],
      description: map['description'],
      orderCode: map['orderCode'],
      currency: map['currency'],
      paymentLinkId: map['paymentLinkId'],
      status: map['status'],
      checkoutUrl: map['checkoutUrl'],
      qrCode: map['qrCode'],
      returncode: map['returncode'],
      return_message: map['return_message'],
      sub_return_code: map['sub_return_code'],
      sub_return_message: map['sub_return_message'],
      order_url: map['order_url'],
      zp_trans_token: map['zp_trans_token'],
      order_token: map['order_token'],
      qr_code: map['qr_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentEntity.fromJson(String source) =>
      PaymentEntity.fromMap(json.decode(source));
}
