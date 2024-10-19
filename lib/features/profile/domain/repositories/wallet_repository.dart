import 'package:base/features/package/data/model/response/packages_response.dart';
import 'package:base/features/package/data/remote/package_source.dart';
import 'package:base/features/package/data/repositories/package_type_repository_impl.dart';
import 'package:base/features/profile/data/models/response/profile_response.dart';
import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:base/features/profile/data/remote/profile_source.dart';
import 'package:base/features/profile/data/remote/wallet_source.dart';
import 'package:base/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:base/features/profile/data/repositories/wallet_repository_impl.dart';

import 'package:base/models/request/paging_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

part 'wallet_repository.g.dart';

abstract class WalletRepository {
  Future<WalletResponse> getWallet({
    required String accessToken,
  });
}

@Riverpod(keepAlive: true)
WalletRepository walletRepository(WalletRepositoryRef ref) {
  final walletSource = ref.read(walletSourceProvider);
  return WalletRepositoryImpl(walletSource);
}
