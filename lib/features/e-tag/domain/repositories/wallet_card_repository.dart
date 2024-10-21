// import 'package:base/features/e-tag/data/model/response/wallet_card_response.dart';
// import 'package:base/features/e-tag/data/remote/wallet_card_source.dart';
// import 'package:base/features/e-tag/data/repositories/wallet_type_repository_impl.dart';
// import 'package:base/features/package/data/model/response/packages_response.dart';
// import 'package:base/features/package/data/remote/package_source.dart';
// import 'package:base/features/package/data/repositories/package_type_repository_impl.dart';
// import 'package:base/features/profile/data/models/response/profile_response.dart';
// import 'package:base/features/profile/data/models/response/wallet_response.dart';
// import 'package:base/features/profile/data/remote/profile_source.dart';
// import 'package:base/features/profile/data/repositories/profile_repository_impl.dart';

// import 'package:base/models/request/paging_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:flutter/widgets.dart';

// part 'wallet_card_repository.g.dart';

// abstract class WalletCardRepository {
//   Future<WalletCardResponse> getEtag({
//     required String accessToken,
//   });

// }

// @Riverpod(keepAlive: true)
// WalletCardRepository walletCardRepository(WalletCardRepositoryRef ref) {
//   final WalletCardSource = ref.read(profileSourceProvider);
//   return WallletCardRepositoryImpl(WalletCardSource);
// }
