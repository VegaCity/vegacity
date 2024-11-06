import 'package:base/features/profile/data/models/response/wallet_response.dart';
import 'package:base/features/profile/data/remote/wallet_source.dart';
import 'package:base/features/profile/data/repositories/wallet_repository_impl.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

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
