// import 'dart:convert';
// import 'package:base/features/profile/domain/entities/user_entity.dart';

// class ProfileEntity {
//   final UserEntity user;
//   // final List<WalletEntity> wallets;

//   ProfileEntity({
//     required this.user,
//     // required this.wallets,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       "data": user.toMap(),
//       // "wallets": wallets.map((wallet) => wallet.toMap()).toList(),
//     };
//   }

//   factory ProfileEntity.fromMap(Map<String, dynamic> map) {
//     return ProfileEntity(
//       user: UserEntity.fromMap(map["data"] ?? {}),
//       // wallets: List<WalletEntity>.from(
//       //   (map["wallets"] ?? []).map((x) => WalletEntity.fromMap(x)),
//       // ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProfileEntity.fromJson(String source) =>
//       ProfileEntity.fromMap(json.decode(source));
// }
