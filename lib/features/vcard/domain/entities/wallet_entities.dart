import 'dart:convert';

class Wallet {
  final String id;
  final String walletTypeId;
  final DateTime crDate;
  final DateTime upsDate;
  final int balance;
  final int balanceHistory;
  final bool deflag;
  final String? userId;
  final String? storeId;
  final DateTime startDate;
  final DateTime endDate;
  final String? store;
  final String? user;
  final String? walletType;
 

  Wallet({
    required this.id,
    required this.walletTypeId,
    required this.crDate,
    required this.upsDate,
    required this.balance,
    required this.balanceHistory,
    required this.deflag,
    this.userId,
    this.storeId,
    required this.startDate,
    required this.endDate,
    this.store,
    this.user,
    this.walletType,
 
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "walletTypeId": walletTypeId,
      "crDate": crDate.toIso8601String(),
      "upsDate": upsDate.toIso8601String(),
      "balance": balance,
      "balanceHistory": balanceHistory,
      "deflag": deflag,
      "userId": userId,
      "storeId": storeId,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "store": store,
      "user": user,
      "walletType": walletType,
   
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      id: map["id"] ?? '',
      walletTypeId: map["walletTypeId"] ?? '',
      crDate: DateTime.parse(map["crDate"]),
      upsDate: DateTime.parse(map["upsDate"]),
      balance: map["balance"]?.toInt() ?? 0,
      balanceHistory: map["balanceHistory"]?.toInt() ?? 0,
      deflag: map["deflag"] ?? false,
      userId: map["userId"],
      storeId: map["storeId"],
      startDate: DateTime.parse(map["startDate"]),
      endDate: DateTime.parse(map["endDate"]),
      store: map["store"],
      user: map["user"],
      walletType: map["walletType"],
     
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source));
}
